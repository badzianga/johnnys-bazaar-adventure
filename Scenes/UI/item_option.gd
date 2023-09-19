class_name ItemOption
extends ColorRect


func set_info(item_info: Dictionary) -> void:
	$Icon.texture = load("res://Assets/Items/" + item_info["Icon"])
	$Name.text = item_info["Name"]
	$Description.text = item_info["Description"]
	$Price.text += str(item_info["Price"])
