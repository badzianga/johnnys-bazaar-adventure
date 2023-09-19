extends Label


@export var speed := 120.0

func play_anim() -> void:
	$AnimationPlayer.play("show")


func _physics_process(delta: float) -> void:
	global_position.y -= delta * speed
