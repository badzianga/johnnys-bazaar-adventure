extends Hitbox

@export var speed := 240.0
@export var penetration := 0
@export var _lifetime := 5.0

var direction: Vector2


func _ready() -> void:
	$LifetimeTimer.wait_time = _lifetime
	$LifetimeTimer.start()


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_area_entered(_hurtbox: Hurtbox) -> void:
	if penetration <= 0:
		queue_free()
	penetration -= 1


func _on_lifetime_timer_timeout() -> void:
	queue_free()
