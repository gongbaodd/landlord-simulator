extends Label

@export var tenant_label: Label

var money_count = 0
const tenant_money_count = 500

func _ready() -> void:
	_update_display()

func _update_display() -> void:
	text = "Money: " + str(money_count)

func _on_time_on_new_month() -> void:
	var tenant_count = tenant_label.get_script().tenant_count
	money_count += tenant_count * tenant_money_count
	_update_display()
