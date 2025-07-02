extends Label

@export var tenant_label: Label

var money_count = 0
const tenant_money_count = 500
const house_price = 1500

func _ready() -> void:
	_update_display()

func _update_display() -> void:
	text = "Money: " + str(money_count)

func _on_time_on_new_month() -> void:
	var tenant_count = tenant_label.tenant_count
	money_count += tenant_count * tenant_money_count
	_update_display()

func is_money_enough() -> bool:
	return money_count >= house_price

func buy_house():
	money_count -= house_price
	_update_display()