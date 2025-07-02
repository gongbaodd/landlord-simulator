extends Label

@export var dialog_control: DialogControl

var experience_count := 0
const success_add_exp_count = 5

func _ready() -> void:
	_update_display()

func _update_display() -> void:
	text = "EXP: " + str(experience_count)

signal on_exp_cut
signal on_exp_cut_failed

func _on_dialog_experience_cut(amount:int) -> void:
	if experience_count - amount > 0:
		experience_count -= amount
		_on_dialog_on_success()
		on_exp_cut.emit()
	else:
		on_exp_cut_failed.emit()


func _on_dialog_on_success() -> void:
	experience_count += success_add_exp_count
	_update_display()
