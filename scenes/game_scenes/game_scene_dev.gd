extends Node2D

@export var waypoints: Array[Marker2D] = []

func _ready() -> void:
    GameManager.start_game()