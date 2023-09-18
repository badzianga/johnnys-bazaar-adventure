class_name Coin
extends Area2D

var speed := 0.0
var value := 1


func _ready() -> void:
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	speed += 8.0 * delta
	global_position = global_position.move_toward(GameController.player.global_position, speed)


func grab() -> void:
	print("grabbed")
	set_physics_process(true)


func collect() -> int:
	print("collected")
	queue_free()
	return value
