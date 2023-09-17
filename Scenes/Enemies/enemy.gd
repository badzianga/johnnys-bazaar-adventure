extends CharacterBody2D


@onready var _sprite := $Sprite
@onready var _velocity_component := $VelocityComponent as VelocityComponent
@onready var _health_component := $HealthComponent as HealthComponent
@onready var _animation_player: AnimationPlayer = $Sprite/AnimationPlayer


func _ready() -> void:
	_health_component.health_depleted.connect(_on_health_changed)


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
	queue_free()
