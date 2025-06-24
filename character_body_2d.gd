extends CharacterBody2D

var speed = 100
var player_state

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
	play_anim(direction)

func play_anim(dir):
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	if player_state == "walking":
		$AnimatedSprite2D.play("walking")
		if dir.y == -1:
			$AnimatedSprite2D.play("move_up")
		if dir.x == -1:
			$AnimatedSprite2D.play("move_left")
		if dir.y == 1:
			$AnimatedSprite2D.play("move_down")
