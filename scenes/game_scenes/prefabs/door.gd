extends Area2D

@export var dialog_data: DialogueData

@export var closed_color: Color = Color(1, 0, 0)
@export var open_color: Color = Color(0, 1, 0)

var player_inside := false
var is_open := false
var is_visited := false
var dialog_control: DialogControl

func _ready() -> void:
	if !dialog_control:
		push_error("Dialog control not set. Please assign a Control node to dialog_control.")
	dialog_control = GameManager.dialog_control
	_update_door_state()

func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("use"):
		is_open = !is_open
		_update_door_state()
		dialog_control.hide_dialogue()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = true
		if !is_visited:
			dialog_control.show_dialogue(dialog_data)
			is_visited = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false

@onready var sprite: Sprite2D = get_node("StaticBody2D/Sprite2D")
@onready var collision_shape: CollisionShape2D = get_node("StaticBody2D/CollisionShape2D")

func _update_door_state() -> void:
	sprite.modulate = open_color if is_open else closed_color
	collision_shape.disabled = is_open
