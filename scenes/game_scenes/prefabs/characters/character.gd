extends CharacterBody2D

# @export var movement_x: float = 0
# @export var movement_y: float = 0
@export var movement_speed: float = 100.0

@onready var ground_scene: Node2D = get_parent()
@onready var waypoints: Array[Marker2D] = ground_scene.waypoints if ground_scene else []
@onready var animation_tree: AnimationTree = $Animator/AnimationTree if $Animator else null
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
var player_inside := false
var current_target_waypoint_pos = Vector2.ZERO

func _ready() -> void:
	_choose_next_waypoint()

func _process(_delta: float) -> void:
	if player_inside: 
		if Input.is_action_just_pressed("use") and !GameManager.running_dialog:
			var dialog = DialogueManager.show_example_dialogue_balloon(load("res://scenes/game_scenes/dialogues/character.dialogue"), "start")
			GameManager.running_dialog = dialog
	else:
		pass
		# velocity = Vector2(movement_x, movement_y) * movement_speed
		# move_and_slide()

	if animation_tree:
		pass
		# animation_tree.set("parameters/blend_position", Vector2(movement_x, movement_y))

func _physics_process(_delta: float) -> void:
	if nav_agent.is_navigation_finished():
		return
	var next_waypoint_pos = nav_agent.get_next_path_position()
	var direction = (next_waypoint_pos - position).normalized()
	velocity = direction * movement_speed
	move_and_slide()

func _choose_next_waypoint() -> void:
	var random_index: int = randi_range(0, waypoints.size() - 1)
	current_target_waypoint_pos = waypoints[random_index].position
	nav_agent.target_position = current_target_waypoint_pos

func _on_body_entered(body:Node2D) -> void:
	if body.name == "Player":
		player_inside = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false
