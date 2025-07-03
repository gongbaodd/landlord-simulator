extends Area2D

var player_inside := false

func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("use") && !GameManager.running_dialog:
		var dialog = DialogueManager.show_example_dialogue_balloon(load("res://scenes/game_scenes/dialogues/house.dialogue"), "start")
		GameManager.running_dialog = dialog


func _on_body_entered(body:Node2D) -> void:
	if body.name == "Player":
		player_inside = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false
