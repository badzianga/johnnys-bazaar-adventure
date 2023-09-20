extends CanvasLayer


const ItemOptionScene := preload("res://Scenes/UI/item_option.tscn")

@onready var container := $Background/Container
@onready var coins_label := $Background/CoinsLabel


func _ready() -> void:
	coins_label.text = "Coins: " + str(GameController.coins)
	for i in range(4):
		_create_option()

	print("Available upgrades after creation: ", len(Upgrades.available_upgrades))


func _create_option(delayed: bool = false) -> void:
	if len(Upgrades.available_upgrades) <= 0:
		return
	var option := ItemOptionScene.instantiate()
	option.set_info(Upgrades.available_upgrades.pick_random())
	option.item_purchased.connect(_on_item_purchased)
	option.display(delayed)
	# I don't want to create few entries of the same upgrade, so this is necessary
	GameController.remove_available_upgrade(option.item_id)
	container.add_child(option)


func _on_item_purchased(item_option: ItemOption) -> void:
	GameController.coins -= item_option.price
	GameController.purchased_upgrades.append(item_option.item_name)
	GameController.upgrade_character(item_option.item_id)
	coins_label.text = "Coins: " + str(GameController.coins)
	# I'm removing it from here and adding it to _create_option()
	#GameController.remove_available_upgrade(item_option.item_id)
	item_option.delete()
	_create_option(true)


func _on_next_wave_button_pressed() -> void:
	# After the bazaar and just before the next wave, retrieve left options
	# and add them again to available_upgrades
	for option in container.get_children():
		Upgrades.available_upgrades.append(option.data)
	GameController.back_to_world()
