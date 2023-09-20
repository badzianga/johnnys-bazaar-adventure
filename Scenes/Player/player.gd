extends CharacterBody2D


const LightOrbScene := preload("res://Scenes/Attacks/light_orb.tscn")
const DamageIndicatorScene := preload("res://Scenes/Misc/damage_indicator.tscn")

@export var speed = 320.0
@export var health := 10

var direction := Vector2.ZERO
var current_animation: String
var coins: int
var _orbs_to_shoot := 0

@onready var animation_player := $Sprite2D/AnimationPlayer
@onready var sprite := $Sprite2D
@onready var volley_timer := $ShootCooldown/VolleyTimer
@onready var invincibility_timer := $InvincibilityTimer
@onready var hurt_effect := $Sprite2D/HurtEffect
@onready var indicator_marker := $IndicatorMarker
@onready var hurtbox_collider := $Hurtbox/CollisionShape2D


func _ready() -> void:
	_upgrade_character()
	GameController.player = self
	coins = GameController.coins
	Hud.set_max_health(health)
	Hud.set_health(health)
	Hud.set_coins(coins)
	$ShootCooldown.start()
	hurt_effect.play("RESET")


func _physics_process(_delta: float) -> void:
	_handle_movement()
	_handle_animations()


func _handle_movement() -> void:
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")

	velocity = direction.normalized() * speed

	move_and_slide()


func _handle_animations() -> void:
	if direction:
		_play_animation("walk")
	else:
		_play_animation("idle")

	if direction.x == 0:
		return
	sprite.flip_h = (direction.x < 0)


func _play_animation(anim_name: String) -> void:
	if current_animation == anim_name:
		return
	animation_player.play("RESET")
	await animation_player.animation_finished
	animation_player.play(anim_name)
	current_animation = anim_name 


func _upgrade_character() -> void:
	health += PlayerUpgrades.max_health
	speed *= PlayerUpgrades.speed_multiplier
	$ShootCooldown.wait_time = ($ShootCooldown.wait_time - PlayerUpgrades.cooldown_reduce_sec) * PlayerUpgrades.cooldown_multiplier


func _shoot() -> void:
	var light_orb := LightOrbScene.instantiate()
	light_orb.global_position = global_position

	# upgrade orb
	light_orb.damage = ceil((light_orb.damage + PlayerUpgrades.extra_damage) * PlayerUpgrades.damage_multiplier)
	light_orb.penetration += PlayerUpgrades.penetration
	light_orb.speed *= PlayerUpgrades.bullet_speed_multiplier
	
	if len(GameController.enemies) > 0:
		var random_enemy: Enemy = GameController.enemies.pick_random()
		light_orb.direction = global_position.direction_to(random_enemy.global_position)
	else:
		light_orb.direction = Vector2.from_angle(randf_range(0.0, TAU))
	get_parent().add_child(light_orb)


func _spawn_indicator(value: int) -> void:
	var indicator := DamageIndicatorScene.instantiate()
	indicator.global_position = indicator_marker.global_position
	indicator.text = str(value)
	indicator.scale *= 1.2
	indicator.play_anim()
	get_tree().get_root().add_child(indicator)


func _make_invincible() -> void:
	hurtbox_collider.set_deferred("disabled", true)
	invincibility_timer.start()


func _on_hurtbox_area_entered(hitbox: Area2D) -> void:
	health -= hitbox.damage
	hurt_effect.play("hurt")
	_spawn_indicator(hitbox.damage)
	_make_invincible()
	Hud.set_health(health)
	if health <= 0:
		GameController.go_to_result_screen()


func _on_shoot_cooldown_timeout() -> void:
	_orbs_to_shoot = 1 + PlayerUpgrades.extra_bullets
	volley_timer.start()


func _on_volley_timer_timeout() -> void:
	if _orbs_to_shoot > 0:
		_shoot()
		volley_timer.start()
		_orbs_to_shoot -= 1


func _on_loot_collect_area_entered(coin: Coin) -> void:
	coins += coin.collect()
	Hud.set_coins(coins)


func _on_loot_grab_area_entered(coin: Coin) -> void:
	coin.grab()


func _on_invincibility_timer_timeout() -> void:
	hurtbox_collider.set_deferred("disabled", false)
