extends Control

@onready var dialogue_box = $DialogueBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue_box.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
