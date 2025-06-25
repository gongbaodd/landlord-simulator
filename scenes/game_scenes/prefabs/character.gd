extends Area2D

@export var dialog_control: DialogControl
@export var dialog_data: DialogueData

var player_inside := false

func _ready() -> void:
	if !dialog_control:
		push_error("Dialog control not set. Please assign a Control node to dialog_control.")


func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("use"):
		dialog_control.show_dialogue(dialog_data)


func _on_body_entered(body:Node2D) -> void:
	if body.name == "Player":
		player_inside = true
