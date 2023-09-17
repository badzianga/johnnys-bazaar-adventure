extends CharacterBody2D


@export var speed = 320.0

var health := 10
var direction := Vector2.ZERO
var current_animation: String

@onready var animation_player := $Sprite2D/AnimationPlayer
@onready var sprite := $Sprite2D


func _ready() -> void:
	GameController.player = self
	Hud.set_max_health(health)
	Hud.set_health(health)


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


func _hurt(damage: int) -> void:
	health -= damage
	Hud.set_health(health)
	if health <= 0:
		get_tree().reload_current_scene()


func _on_hurtbox_area_entered(hitbox: Area2D) -> void:
	_hurt(hitbox.damage)
