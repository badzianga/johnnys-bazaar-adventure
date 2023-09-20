extends Node

# player-related upgrades
var max_health := 0
var speed_multiplier := 1.0
var extra_damage := 0
var damage_multiplier := 1.0
var extra_bullets := 0
var penetration := 0
var cooldown_reduce_sec := 0.0
var cooldown_multiplier := 1.0
var bullet_speed_multiplier := 1.0

# djed-related upgrades
var djeds := 0
var djed_extra_damage := 0
var djed_damage_multiplier := 1.0
var djed_extra_bullets := 0
var djed_penetration := 0
var djed_cooldown_multiplier := 1.0
var djed_bullet_speed_multiplier := 1.0


func reset() -> void:
	max_health = 0
	speed_multiplier = 1.0
	extra_damage = 0
	damage_multiplier = 1.0
	extra_bullets = 0
	penetration = 0
	cooldown_reduce_sec = 0.0
	cooldown_multiplier = 1.0
	bullet_speed_multiplier = 1.0

# djed-related upgrades
	djeds = 0
	djed_extra_damage = 0
	djed_damage_multiplier = 1.0
	djed_extra_bullets = 0
	djed_penetration = 0
	djed_cooldown_multiplier = 1.0
	djed_bullet_speed_multiplier = 1.0
