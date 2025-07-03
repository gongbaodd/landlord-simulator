extends CharacterBody2D

const speed = 500
@onready var animation_tree: AnimationTree = get_node("animation").get_node("AnimationTree")

func _physics_process(_delta: float) -> void:
	if !GameManager.running_dialog:
		var direction = Input.get_vector("move_left","move_right","move_up","move_down")
		velocity = direction * speed
		animation_tree.set("parameters/blend_position", direction)
		move_and_slide()
