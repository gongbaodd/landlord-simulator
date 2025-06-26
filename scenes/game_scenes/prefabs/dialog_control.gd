class_name DialogControl
extends Control

@onready var dialogue_box = $DialogueBox

func _ready():
	dialogue_box.visible = false

var cut_experience_amount: int = 0
func show_dialogue(dialogData: DialogueData, user_cut_experience_count: int = cut_experience_amount) -> void:
	dialogue_box.visible = true
	if not dialogue_box.is_running():
		dialogue_box.data = dialogData
		dialogue_box.start()
		cut_experience_amount = user_cut_experience_count

func hide_dialogue() -> void:
	dialogue_box.stop()
	dialogue_box.visible = false
	cut_experience_amount = 0

signal experience_cut(amount: int)

func _on_dialogue_box_dialogue_signal(value:String) -> void:
	match value:
		"exp_cut":
			emit_signal("experience_cut", cut_experience_amount)