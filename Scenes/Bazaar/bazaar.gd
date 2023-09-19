extends CanvasLayer


const ItemOptionScene := preload("res://Scenes/UI/item_option.tscn")

@onready var container := $Background/Container
@onready var coins_label := $Background/CoinsLabel

func _ready() -> void:
	coins_label.text = "Coins: " + str(GameController.coins)
	for i in range(4):
		_create_option()


func _create_option() -> void:
	var option := ItemOptionScene.instantiate()
	option.set_info(Upgrades.upgrades.pick_random())
	option.item_purchased.connect(_on_item_purchased)
	container.add_child(option)


func _on_item_purchased(item_option: ItemOption) -> void:
	GameController.coins -= item_option.price
	GameController.purchased_upgrades.append(item_option.item_name)
	GameController.upgrade_character(item_option.item_name)
	coins_label.text = "Coins: " + str(GameController.coins)
	item_option.delete()


func _on_next_wave_button_pressed() -> void:
	GameController.back_to_world()
