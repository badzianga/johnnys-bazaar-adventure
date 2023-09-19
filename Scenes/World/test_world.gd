extends Node2D


const DjedScene := preload("res://Scenes/Djed/djed.tscn")


func _ready() -> void:
	for _i in range(PlayerUpgrades.djeds):
		_spawn_djed()


func _spawn_djed() -> void:
	var djed := DjedScene.instantiate()
	djed.global_position = Vector2(randf_range(750.0, 1750.0), randf_range(750.0, 1750.0))
	add_child(djed)
