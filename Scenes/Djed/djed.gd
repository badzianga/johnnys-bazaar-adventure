extends StaticBody2D


const LightOrbScene := preload("res://Scenes/Attacks/light_orb.tscn")

@onready var marker := $Marker


func _ready() -> void:
	$AnimationPlayer.speed_scale = PlayerUpgrades.djed_cooldown_multiplier


# Used by animation player
func shoot() -> void:
	for _i in range(1 + PlayerUpgrades.djed_extra_bullets):
		var light_orb := LightOrbScene.instantiate()
		light_orb.global_position = marker.global_position
		
		# upgrade orb
		light_orb.damage = ceil((light_orb.damage + PlayerUpgrades.djed_extra_damage) * PlayerUpgrades.djed_damage_multiplier)
		light_orb.penetration += PlayerUpgrades.djed_penetration
		light_orb.speed *= PlayerUpgrades.djed_bullet_speed_multiplier
		
		if len(GameController.enemies) > 0:
			var random_enemy: Enemy = GameController.enemies.pick_random()
			light_orb.direction = global_position.direction_to(random_enemy.global_position)
		else:
			light_orb.direction = Vector2.from_angle(randf_range(0.0, TAU))
		get_tree().get_root().add_child(light_orb)
