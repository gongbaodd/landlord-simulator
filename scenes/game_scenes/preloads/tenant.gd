extends Label

var tenant_count = 0

func _ready() -> void:
	_update_display()

func _update_display() -> void:
	text = "Tenant: " + str(tenant_count)

func add_tenant() -> void:
	tenant_count += 1
	_update_display()