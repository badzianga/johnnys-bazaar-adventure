class_name ItemOption
extends TextureRect


signal item_purchased(item_option: ItemOption)

var item_name: StringName
var price: int


func set_info(item_info: Dictionary) -> void:
	$Icon.texture = load("res://Assets/Items/" + item_info["Icon"])
	item_name = item_info["Name"]
	$Name.text = item_name
	$Description.text = item_info["Description"]
	price = item_info["Price"]
	$Price.text += str(price)


func delete() -> void:
	$AnimationPlayer.play("delete")


func _on_button_pressed() -> void:
	if GameController.coins >= price:
		item_purchased.emit(self)
