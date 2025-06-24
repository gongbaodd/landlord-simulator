extends Button

@export var dev_scene: PackedScene

func _on_pressed() -> void:
	get_tree().change_scene_to_packed(dev_scene)
