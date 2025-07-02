extends Node2D

@export var dialog_control: DialogControl

@onready var canvas_layer: CanvasLayer = $CanvasLayer

func _ready() -> void:
    canvas_layer.visible = false

func start_game():
    canvas_layer.visible = true