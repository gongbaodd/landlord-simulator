extends Node2D

@onready var door_name: String = GameManager.room_entered if GameManager.room_entered != "" else "Door"
@onready var slot1: Node2D = $Slot1
@onready var slot2: Node2D = $Slot2
@onready var slot3: Node2D = $Slot3
@onready var slot4: Node2D = $Slot4

func _ready() -> void:
	var door_state = GameManager.door_states[door_name]
	for tenant_name in door_state["tenants"]:
		var tenant_scene = load("res://" + tenant_name + ".tscn")
		var tenant = tenant_scene.instantiate()
		tenant.scale = Vector2(3, 3)
		for slot in [slot1, slot2, slot3, slot4]:
			if slot.get_child_count() == 0:
				slot.add_child(tenant)
				break
		
