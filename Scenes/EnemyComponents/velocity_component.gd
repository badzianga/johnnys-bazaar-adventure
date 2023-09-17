class_name VelocityComponent
extends Node2D


@export var _speed := 100.0

var direction := Vector2.ZERO


func move(body: CharacterBody2D) -> void:
	direction = global_position.direction_to(GameController.player.global_position)
	body.velocity = direction * _speed

	body.move_and_slide()
