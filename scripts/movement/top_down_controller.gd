extends CharacterBody2D

@export var dialog_control: DialogControl
const speed = 500

func _physics_process(_delta: float) -> void:
	if !dialog_control.dialogue_box.visible:
		var direction = Input.get_vector("move_left","move_right","move_up","move_down")
		velocity = direction * speed
		move_and_slide()
