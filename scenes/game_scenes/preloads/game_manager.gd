extends Node2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var time: Label = canvas_layer.get_node("Time")
@onready var money_label: Label = canvas_layer.get_node("Money")
@onready var exp_label: Label = canvas_layer.get_node("ExpCount")
@onready var tenant_label: Label = canvas_layer.get_node("Tenant")

var running_dialog: Node = null

func _ready() -> void:
	canvas_layer.visible = false

func start_game():
	canvas_layer.visible = true
	time.start_countdown()

func is_money_enough() -> bool:
	return money_label.is_money_enough()

func buy_house():
	money_label.buy_house()

func is_exp_enough() -> bool:
	return exp_label.is_exp_enough()

func rent_room_with_exp():
	exp_label.rent_room_with_exp()
	tenant_label.add_tenant()

func rent_room():
	exp_label.rent_room()
	tenant_label.add_tenant()

var dialog_points = 0
const dialog_points_needed_to_rent = 60

func add_dialog_points(amount: int):
	dialog_points += amount

func is_dialog_points_enough() -> bool:
	return dialog_points >= dialog_points_needed_to_rent

func reset_dialog_points():
	dialog_points = 0

