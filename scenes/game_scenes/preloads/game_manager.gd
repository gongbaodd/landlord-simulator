extends Node2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var time: Label = canvas_layer.get_node("Time")
@onready var money_label: Label = canvas_layer.get_node("Money")
@onready var exp_label: Label = canvas_layer.get_node("ExpCount")
@onready var tenant_label: Label = canvas_layer.get_node("Tenant")

var running_dialog: Node = null
var house_to_buy: String = ""
var tenant_to_rent: String = ""

var door_states: Dictionary = {
	"Door": {
		"has_key": true,
		"room_count": 4,
		"tenants": [],
	},
	"Door2": {
		"has_key": false,
		"room_count": 4,
		"tenants": [],
	},
	"Door3": {
		"has_key": false,
		"room_count": 4,
		"tenants": [],
	},
	"Door4": {
		"has_key": false,
		"room_count": 4,
		"tenants": [],
	},
	"DoorRed": {
		"has_key": false,
		"room_count": 4,
		"tenants": [],
	},
	"DoorRed2": {
		"has_key": false,
		"room_count": 4,
		"tenants": [],
	},
	"DoorRed3": {
		"has_key": false,
		"room_count": 4,
		"tenants": [],
	},
}

func _ready() -> void:
	canvas_layer.visible = false

func start_game_if_not_started():
	if canvas_layer.visible: return
	canvas_layer.visible = true
	time.start_countdown()

func is_money_enough() -> bool:
	return money_label.is_money_enough()

func buy_house():
	door_states[house_to_buy]["has_key"] = true
	money_label.buy_house()
	house_to_buy = ""

func is_exp_enough() -> bool:
	return exp_label.is_exp_enough()

func has_room_left() -> bool:
	return pick_room_to_rent() != ""

func pick_room_to_rent() -> String:
	var houses_with_key = door_states.keys().filter(func(key: String): return door_states[key]["has_key"])
	for house in houses_with_key:
		if door_states[house]["room_count"] > door_states[house]["tenants"].size():
			return house
	return ""

func rent_room_with_exp():
	exp_label.rent_room_with_exp()
	tenant_label.add_tenant()
	_send_tenant_to_one_room()

func rent_room():
	exp_label.rent_room()
	tenant_label.add_tenant()
	_send_tenant_to_one_room()

signal tenant_rented(tenant_name: String)

func _send_tenant_to_one_room():
	var house_to_rent = pick_room_to_rent()
	door_states[house_to_rent]["tenants"].append(tenant_to_rent)
	door_states[house_to_rent]["room_count"] -= 1
	tenant_rented.emit(tenant_to_rent)
	tenant_to_rent = ""

var dialog_points = 0
const dialog_points_needed_to_rent = 60

func add_dialog_points(amount: int):
	dialog_points += amount

func is_dialog_points_enough() -> bool:
	return dialog_points >= dialog_points_needed_to_rent

func reset_dialog_points():
	dialog_points = 0
