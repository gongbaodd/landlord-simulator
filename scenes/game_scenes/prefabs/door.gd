extends Area2D

# @export var dialog_data: DialogueData

@export var closed_color: Color = Color(1, 0, 0)
@export var open_color: Color = Color(0, 1, 0)

@export var room_scene: PackedScene
@export var transition: PackedScene

var player_inside := false
var is_open := false
var is_visited := false
var balloon_scene: Node

func _ready() -> void:
	_update_door_state()

func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("use"):
		is_open = !is_open
		_update_door_state()
		balloon_scene.queue_free()
		GameManager.running_dialog = null
		if is_open:
			SceneTransitionManager.change_scene_with_transition(
				room_scene,
				transition
			)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = true
		if !is_visited && !GameManager.running_dialog:
			balloon_scene = DialogueManager.show_example_dialogue_balloon(load("res://scenes/game_scenes/dialogues/interact.dialogue"), "start")
			is_visited = true
			GameManager.running_dialog = balloon_scene

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false

@onready var sprite: Sprite2D = get_node("StaticBody2D/Sprite2D")
@onready var collision_shape: CollisionShape2D = get_node("StaticBody2D/CollisionShape2D")

func _update_door_state() -> void:
	sprite.modulate = open_color if is_open else closed_color
	collision_shape.disabled = is_open
