extends Control


func _ready() -> void:
	GameController.play_music("menu")


func _on_play_button_pressed() -> void:
	GameController.play_music("game")
	GameController.back_to_world()


func _on_exit_button_pressed() -> void:
	get_tree().exit()
