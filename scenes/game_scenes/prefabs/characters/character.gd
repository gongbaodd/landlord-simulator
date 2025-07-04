extends CharacterBody2D

# @export var movement_x: float = 0
# @export var movement_y: float = 0
@export var movement_speed: float = 100.0
@export var wait_time: float = 1.0
@export var dialogue_data: DialogueResource = load("res://scenes/game_scenes/dialogues/character.dialogue")

@onready var ground_scene := get_parent()
@onready var waypoints: Array[Marker2D] = ground_scene.waypoints if ground_scene else []
@onready var animation_tree: AnimationTree = $Animator/AnimationTree if $Animator else null
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
var player_inside := false
var current_target_waypoint_pos = Vector2.ZERO
var is_waiting := false

func _ready() -> void:
	if GameManager.check_if_tenant_rented(name): queue_free()
	call_deferred("_choose_next_waypoint")
	GameManager.tenant_rented.connect(_on_tenant_rented)

func _process(_delta: float) -> void:
	if player_inside:
		if Input.is_action_just_pressed("use") and !GameManager.running_dialog: _talk()

func _physics_process(_delta: float) -> void:
	if player_inside: _idle(); return

	if nav_agent.is_navigation_finished():
		if is_waiting: _idle(); return
		else: _on_navigation_target_reached(); return
	else: _move()

func _talk() -> void:
	GameManager.running_dialog = DialogueManager.show_example_dialogue_balloon(dialogue_data, "start")
	GameManager.tenant_to_rent = name

func _move() -> void:
	var next_waypoint_pos = nav_agent.get_next_path_position()
	var direction = (next_waypoint_pos - position).normalized()
	velocity = direction * movement_speed
	move_and_slide()
	_set_animation_tree(direction)

func _idle() -> void:
	velocity = Vector2.ZERO
	move_and_slide()
	_set_animation_tree(Vector2.ZERO)

func _on_navigation_target_reached() -> void:
	is_waiting = true
	await get_tree().create_timer(wait_time).timeout
	is_waiting = false
	_choose_next_waypoint()

func _choose_next_waypoint() -> void:
	var random_index: int = randi_range(0, waypoints.size() - 1)
	current_target_waypoint_pos = waypoints[random_index].position
	nav_agent.target_position = current_target_waypoint_pos

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false

func _set_animation_tree(direction: Vector2) -> void:
	if animation_tree:
		animation_tree.set("parameters/blend_position", direction)

func _on_tenant_rented(tenant_name: String) -> void:
	if name == tenant_name:
		queue_free()
