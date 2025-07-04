extends Area2D

@export var room_scene: PackedScene
@export var transition: PackedScene

var player_inside := false
var open_door_dialogue := load("res://scenes/game_scenes/dialogues/interact.dialogue")
var world_scene := load("res://scenes/game_scenes/game_scene_dev.tscn")

func _ready() -> void:
	if not room_scene: room_scene = world_scene # will cause circular dependency if used in the export

func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("use"):
		if _check_if_has_key(): _enter_room()

func _enter_room() -> void:
	GameManager.room_entered = name
	GameManager.running_dialog = null
	SceneTransitionManager.change_scene_with_transition(
		room_scene,
		transition
	)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = true
		if _check_if_has_key():
			GameManager.running_dialog = DialogueManager.show_example_dialogue_balloon(open_door_dialogue, "start")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false

func _check_if_has_key() -> bool:
	if GameManager.door_states.has(name):
		return GameManager.door_states[name]["has_key"]
	return true #indoor

