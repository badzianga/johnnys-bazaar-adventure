extends TextureRect


@onready var dialogue_box := $DialogueSystem
@onready var ra := $Ra
@onready var player := $Player


func _ready() -> void:
	dialogue_box.name_changed.connect(_on_name_changed)


func _on_skip_button_pressed() -> void:
	GameController.back_to_world()


func _on_name_changed(actor_name: String) -> void:
	if actor_name == "Ra":
		ra.visible = true
		player.visible = false
	else:
		ra.visible = false
		player.visible = true


func _on_dialogue_system_tree_exited() -> void:
	GameController.back_to_world()
