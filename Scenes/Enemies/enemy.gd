class_name Enemy
extends CharacterBody2D


const CoinScene := preload("res://Scenes/Loot/coin.tscn")
const DamageIndicatorScene := preload("res://Scenes/Misc/damage_indicator.tscn")

@export var max_health := 10
@export var speed := 160.0
@export var damage := 1
@export var gold_min := 0
@export var gold_max := 1

@onready var _sprite := $Sprite
@onready var _velocity_component := $VelocityComponent as VelocityComponent
@onready var _health_component := $HealthComponent as HealthComponent
@onready var _animation_player := $Sprite/AnimationPlayer
@onready var _effects := $Sprite/Effects
@onready var indicator_marker := $IndicatorMarker
@onready var hit_sound := $HitSound


func _ready() -> void:
	_health_component.health_changed.connect(_on_health_changed)
	_health_component.health_depleted.connect(_on_health_depleted)

	_health_component.max_health = max_health
	_health_component.health = max_health
	_velocity_component.speed = speed
	$Hitbox.damage = damage


func _physics_process(_delta: float) -> void:
	_velocity_component.move(self)
	_handle_animation()


func _handle_animation() -> void:
	if _velocity_component.direction.x < 0:
		_sprite.flip_h = true
		_animation_player.play("walk_left")
	else:
		_sprite.flip_h = false
		_animation_player.play("walk_right")


func _spawn_coins() -> void:
	var amount := randi_range(gold_min, gold_max)
	for _i in amount:
		var coin := CoinScene.instantiate()
		coin.global_position = Vector2(
				global_position.x + randf_range(-32.0, 32.0),
				global_position.y + randf_range(-32.0, 32.0)
		)
		coin.rotation_degrees = randf_range(-180.0, 180.0)
		get_tree().get_first_node_in_group("Loot").call_deferred("add_child", coin)


func _on_health_changed(amount: int) -> void:
	_effects.play("hurt")
	hit_sound.pitch_scale = randf_range(0.8, 1.2)
	hit_sound.play()
	var indicator := DamageIndicatorScene.instantiate()
	indicator.global_position = indicator_marker.global_position
	indicator.text = str(amount)
	indicator.play_anim()
	get_tree().get_root().add_child(indicator)


func _on_health_depleted() -> void:
	GameController.enemies.erase(self)
	set_physics_process(false)
	$CollisionShape.set_deferred("disabled", true)
	$Hurtbox/CollisionShape.set_deferred("disabled", true)
	$Hitbox/CollisionShape.set_deferred("disabled", true)
	$Sprite/AnimationPlayer.pause()
	_effects.play("death")
	_spawn_coins()
	await _effects.animation_finished
	queue_free()
