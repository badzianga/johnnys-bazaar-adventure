extends CharacterBody2D


@onready var _sprite := $Sprite
@onready var _velocity_component := $VelocityComponent as VelocityComponent
@onready var _health_component := $HealthComponent as HealthComponent
@onready var _animation_player := $Sprite/AnimationPlayer
@onready var _effects := $Sprite/Effects


func _ready() -> void:
	_health_component.health_changed.connect(_on_health_changed)
	_health_component.health_depleted.connect(_on_health_depleted)


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


func _on_health_changed() -> void:
	_effects.play("hurt")


func _on_health_depleted() -> void:
	GameController.enemies.erase(self)
	queue_free()
