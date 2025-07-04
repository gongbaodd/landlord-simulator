extends Label

@export var dialog_control: DialogControl

var experience_count := 100
const success_add_exp_count = 5
const exp_needed_to_rent = 10

func _ready() -> void:
	_update_display()

func _update_display() -> void:
	text = "EXP: " + str(experience_count)

func is_exp_enough() -> bool:
	return experience_count >= exp_needed_to_rent

func rent_room_with_exp() -> void:
	experience_count -= exp_needed_to_rent
	_update_display()

func rent_room() -> void:
	experience_count += success_add_exp_count
	_update_display()
