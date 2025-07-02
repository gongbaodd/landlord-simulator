extends Node2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var time: Label = canvas_layer.get_node("Time")
@onready var money_label: Label = canvas_layer.get_node("Money")

func _ready() -> void:
	canvas_layer.visible = false

func start_game():
	canvas_layer.visible = true
	time.start_countdown()

const house_price = 1500

func buy_house() -> bool:
	if (money_label.money_count - house_price) > 0:
		money_label.money_count -= house_price
		return true
	else:
		return false
