extends Label

var tenant_count = 0

func _ready() -> void:
	_update_display()

func _update_display() -> void:
	text = "Tenant: " + str(tenant_count)

func _on_exp_count_on_exp_cut() -> void:
	_on_dialog_on_success()

func _on_dialog_on_success() -> void:
	tenant_count += 1
	_update_display()