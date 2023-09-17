class_name Hurtbox
extends Area2D


@export var health_component: HealthComponent
@export var collision_shape: CollisionShape2D


func _on_area_entered(hitbox: Hitbox) -> void:
	health_component.apply_damage(hitbox.damage)
