extends Node2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var time: Label = canvas_layer.get_node("Time")

func _ready() -> void:
    canvas_layer.visible = false

func start_game():
    canvas_layer.visible = true
    time.start_countdown()