class_name DialogControl
extends Control

@onready var dialogue_box = $DialogueBox

func _ready():
	dialogue_box.visible = false

var cut_experience_amount: int = 0
func show_dialogue(dialogData: Node, user_cut_experience_count: int = cut_experience_amount) -> void:
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
signal on_success_rent
signal on_buy_house

func _on_dialogue_box_dialogue_signal(value:String) -> void:
	match value:
		"exp_cut":
			experience_cut.emit(cut_experience_amount)
		"SUCCESS":
			on_success_rent.emit()
		"BUY":
			on_buy_house.emit()
