extends ColorRect


func _ready() -> void:
	if GameController.current_wave >= len(GameController.WAVE_TIMES):
		$Label.text = "YOU WIN!"
		color = Color(0.12, 0.21, 0.18)
		$Ra.visible = true
		$Player.visible = true
	else:
		$Label.text = "YOU LOSE!"
		color = Color(0.31, 0.18, 0.15)
		$Mummy.visible = true
		$Dog.visible = true
		$Scorpio.visible = true
		$Snake.visible = true


func _on_button_pressed() -> void:
	GameController.reset_game()
