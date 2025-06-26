extends Node2D

@export var dialog_control: DialogControl
@export var exp_label: Label

var experience_count := 0

func _ready() -> void:
	dialog_control.experience_cut.connect(_on_experience_cut)

func _on_experience_cut(amount: int) -> void:
	experience_count -= amount
	exp_label.text = "EXP: " + str(experience_count)
