extends Node2D


const DjedScene := preload("res://Scenes/Djed/djed.tscn")
const CoinScene := preload("res://Scenes/Loot/coin.tscn")


func _ready() -> void:
	if GameController.current_wave < 10:
		GameController.play_music("wave")
	else:
		GameController.play_music("wave10")
	
	for _i in range(PlayerUpgrades.djeds):
		_spawn_djed()
	
	var loot := $Loot
	for _i in range(GameController.coins_left):
		_spawn_coin(loot)


func _spawn_djed() -> void:
	var djed := DjedScene.instantiate()
	djed.global_position = Vector2(randf_range(750.0, 1750.0), randf_range(750.0, 1750.0))
	add_child(djed)


func _spawn_coin(loot: Node2D) -> void:
	var coin := CoinScene.instantiate()
	coin.global_position = Vector2(randf_range(750.0, 1750.0), randf_range(750.0, 1750.0))
	coin.rotation_degrees = randf_range(-180.0, 180.0)
	loot.add_child(coin)
