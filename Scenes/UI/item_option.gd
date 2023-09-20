class_name ItemOption
extends TextureRect


signal item_purchased(item_option: ItemOption)

var data: Dictionary  # too lazy, memory will suffer from it but I don't have much time

var item_id: int
var item_name: StringName
var price: int


func display(delayed: bool) -> void:
	if delayed:
		$AnimationPlayer.play("add_delayed")
	else:
		$AnimationPlayer.play("add")


func set_info(item_info: Dictionary) -> void:
	data = item_info
	$Icon.texture = load("res://Assets/Items/" + item_info["Icon"])
	item_name = item_info["Name"]
	$Name.text = item_name
	$Description.text = item_info["Description"]
	price = item_info["Price"]
	item_id = item_info["Id"]
	$Price.text += str(price)


func delete() -> void:
	$AnimationPlayer.play("delete")


func _on_button_pressed() -> void:
	if GameController.coins >= price:
		item_purchased.emit(self)
