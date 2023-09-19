class_name HealthComponent
extends Node


signal health_changed
signal health_depleted

@export var max_health := 10

var health: int


func _ready() -> void:
	health = max_health


func apply_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		health_depleted.emit()
	else:
		health_changed.emit()
