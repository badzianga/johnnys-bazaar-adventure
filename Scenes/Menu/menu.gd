extends Control


func _ready() -> void:
	GameController.play_music("bazaar")


func _on_play_button_pressed() -> void:
	GameController.show_intro()


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_fullscreen_toggled(button_pressed: bool) -> void:
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
