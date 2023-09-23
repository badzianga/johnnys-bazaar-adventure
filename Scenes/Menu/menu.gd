extends Control


func _ready() -> void:
	GameController.play_music("bazaar")


func _on_play_button_pressed() -> void:
	GameController.show_intro()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
