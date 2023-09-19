extends CanvasLayer


const ItemOptionScene := preload("res://Scenes/UI/item_option.tscn")

@onready var container := $Background/Container


func _ready() -> void:
	for i in range(4):
		_create_option()


func _create_option() -> void:
	var option := ItemOptionScene.instantiate()
	option.set_info(Upgrades.upgrades.pick_random())
	container.add_child(option)
