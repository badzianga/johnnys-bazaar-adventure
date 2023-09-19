extends StaticBody2D


const LightOrbScene := preload("res://Scenes/Attacks/light_orb.tscn")

@onready var marker := $Marker

# Used by animation player
func shoot() -> void:
	var light_orb := LightOrbScene.instantiate()
	light_orb.global_position = marker.global_position
	if len(GameController.enemies) > 0:
		var random_enemy: Enemy = GameController.enemies.pick_random()
		light_orb.direction = global_position.direction_to(random_enemy.global_position)
	else:
		light_orb.direction = Vector2.from_angle(randf_range(0.0, TAU))
	get_tree().get_root().add_child(light_orb)
