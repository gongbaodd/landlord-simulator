extends Area2D

# @export var dialog_data: DialogueData
@export var money_label: Label

const house_price = 1500

var player_inside := false
var dialog_control: DialogControl

func _ready() -> void:
	dialog_control = GameManager.dialog_control
	if !dialog_control:
		push_error("Dialog control not set. Please assign a Control node to dialog_control.")


func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("use"):
		pass
		# dialog_control.show_dialogue(dialog_data,)


func _on_body_entered(body:Node2D) -> void:
	if body.name == "Player":
		player_inside = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false

signal on_buy_house_succeed
signal on_buy_house_failed

func _on_dialog_on_buy_house() -> void:
	if (money_label.money_count - house_price) > 0:
		money_label.money_count -= house_price
		on_buy_house_succeed.emit()
	else:
		on_buy_house_failed.emit()
