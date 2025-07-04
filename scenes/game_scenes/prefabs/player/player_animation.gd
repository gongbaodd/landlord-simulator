extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_tree_animation_finished(anim_name:StringName) -> void:
	print(anim_name)


func _on_animation_player_animation_changed(old_name:StringName, new_name:StringName) -> void:
	print(old_name, new_name)



func _on_animation_player_current_animation_changed(name:String) -> void:
	print(name)


func _on_animation_player_animation_started(anim_name:StringName) -> void:
	print(anim_name)


func _on_animation_tree_animation_player_changed() -> void:
	print("animation_player_changed")