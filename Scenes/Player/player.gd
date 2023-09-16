extends CharacterBody2D


@export var speed = 320.0

var health := 10
var direction := Vector2.ZERO


func _ready() -> void:
	GameController.player = self
	Hud.set_max_health(health)
	Hud.set_health(health)


func _physics_process(_delta: float) -> void:
	_handle_movement()


func _handle_movement() -> void:
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	
	velocity = direction.normalized() * speed

	move_and_slide()


func _hurt(damage: int) -> void:
	health -= damage
	if health <= 0:
		get_tree().reload_current_scene()


func _on_hurtbox_area_entered(hitbox: Area2D) -> void:
	_hurt(hitbox.damage)
