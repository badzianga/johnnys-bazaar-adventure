extends CanvasLayer


const ItemOptionScene := preload("res://Scenes/UI/item_option.tscn")

@onready var container := $Background/Container
@onready var coins_label := $Background/CoinsLabel

func _ready() -> void:
	coins_label.text = "Coins: " + str(GameController.coins)
	for i in range(4):
		_create_option()


func _create_option(delayed: bool = false) -> void:
	var option := ItemOptionScene.instantiate()
	option.set_info(Upgrades.available_upgrades.pick_random())
	option.item_purchased.connect(_on_item_purchased)
	option.display(delayed)
	container.add_child(option)


func _on_item_purchased(item_option: ItemOption) -> void:
	GameController.coins -= item_option.price
	GameController.purchased_upgrades.append(item_option.item_name)
	GameController.upgrade_character(item_option.item_id)
	coins_label.text = "Coins: " + str(GameController.coins)
	GameController.remove_available_upgrade(item_option.item_id)
	print(len(Upgrades.available_upgrades))
	item_option.delete()
	_create_option(true)


func _on_next_wave_button_pressed() -> void:
	GameController.back_to_world()
