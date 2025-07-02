extends Node2D

func _ready() -> void:
    GameManager.start_game()
    DialogueManager.show_example_dialogue_balloon(
        load("res://scenes/game_scenes/dialogues/test.dialogue"), 
        "start"
    )