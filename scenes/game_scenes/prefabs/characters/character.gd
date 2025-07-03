extends Area2D

@export var movement_x: float = 0
@export var movement_y: float = 0
@export var movement_speed: float = 100.0

var animator: Node
var animation_tree: AnimationTree
func _ready() -> void:
	animator = $Animator
	if animator:
		animation_tree = animator.get_node("AnimationTree")

var player_inside := false

func _process(_delta: float) -> void:

	if player_inside: 
		if Input.is_action_just_pressed("use") and !GameManager.running_dialog:
			var dialog = DialogueManager.show_example_dialogue_balloon(load("res://scenes/game_scenes/dialogues/character.dialogue"), "start")
			GameManager.running_dialog = dialog
	else:
		move_local_x(movement_x * _delta * movement_speed)
		move_local_y(movement_y * _delta * movement_speed)
	
	if animation_tree:
		animation_tree.set("parameters/blend_position", Vector2(movement_x, movement_y))


func _on_body_entered(body:Node2D) -> void:
	if body.name == "Player":
		player_inside = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false
