extends Label

@export var dialog_control: DialogControl

var experience_count := 0
var success_add_exp_count = 5

func _ready() -> void:
	text = "EXP: " + str(experience_count)

func _on_dialog_experience_cut(amount:int) -> void:
	if experience_count - amount > 0:
		experience_count -= amount
		experience_count += success_add_exp_count
		text = "EXP: " + str(experience_count)
