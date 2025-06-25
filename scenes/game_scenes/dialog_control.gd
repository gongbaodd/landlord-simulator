class_name DialogControl
extends Control

@onready var dialogue_box = $DialogueBox

func show_dialogue(dialogData: DialogueData) -> void:
	if not dialogue_box.is_running():
		dialogue_box.data = dialogData
		dialogue_box.start()

func hide_dialogue() -> void:
	dialogue_box.stop()