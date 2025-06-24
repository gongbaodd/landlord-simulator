extends Control

var level_scene: PackedScene = load("res://Scene/world.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(level_scene)


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_credit_pressed() -> void:
	pass # Replace with function body.
