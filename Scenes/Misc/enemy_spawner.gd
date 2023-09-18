extends Node2D


enum {
	UP, DOWN, LEFT, RIGHT
}

const SIDES = [UP, DOWN, LEFT, RIGHT]

@export var waves: Array[WaveInfo] = []

var current_wave_info: Array[WaveInfo] = []
var time := 0


func _ready() -> void:
	# prepare wave infos for current wave
	for wave_info in waves:
		if wave_info.wave_number == GameController.current_wave:
			current_wave_info.append(wave_info)


func _spawn_enemies(wave_info: WaveInfo) -> void:
	# check if enemies can spawn randomly
	if randf() > wave_info.spawn_chance:
		return

	var corners := _calculate_corners()

	# spawn enemies
	var enemy_counter := 0
	while enemy_counter < wave_info.amount:
		var enemy: CharacterBody2D = wave_info.enemy.instantiate()
		var pos := _get_random_position(corners)
		enemy.global_position = pos
		add_child(enemy)
		GameController.enemies.append(enemy)  # used for enemy position when attacking
		enemy_counter += 1


func _calculate_corners() -> Array[Vector2]:
	# calculate areas further than viewport for spawn position
	var viewport := get_viewport_rect().size * 1.1
	var top_left: Vector2 = GameController.player.global_position - viewport / 2
	var top_right: Vector2 = Vector2(GameController.player.global_position.x + viewport.x / 2,
			GameController.player.global_position.y - viewport.y / 2)
	var bottom_left: Vector2 = Vector2(GameController.player.global_position.x - viewport.x / 2,
			GameController.player.global_position.y + viewport.y / 2)
	var bottom_right: Vector2 = GameController.player.global_position + viewport / 2

	return [top_left, top_right, bottom_left, bottom_right]


func _get_random_position(corners: Array[Vector2]) -> Vector2:
	# get random side of the screen for enemy spawn
	var spawn_side: int = SIDES.pick_random()
	var spawn_position_begin := Vector2.ZERO
	var spawn_position_end := Vector2.ZERO

	match spawn_side:
		UP:
			spawn_position_begin = corners[0]
			spawn_position_end = corners[1]
		DOWN:
			spawn_position_begin = corners[2]
			spawn_position_end = corners[3]
		LEFT:
			spawn_position_begin = corners[0]
			spawn_position_end = corners[2]
		RIGHT:
			spawn_position_begin = corners[1]
			spawn_position_end = corners[3]  

	# TODO: this is dumb, some of the sides should be eliminated from choosing
	# this will cause a bug in the future, for sure, enemy will spawn on player
	spawn_position_begin.x = max(100, spawn_position_begin.x)
	spawn_position_end.x = min(2400, spawn_position_end.x)
	spawn_position_begin.y = max(100, spawn_position_begin.y)
	spawn_position_end.y = min(2400, spawn_position_end.y)

	# select random position for spawn
	var x_pos := randf_range(spawn_position_begin.x, spawn_position_end.x)
	var y_pos := randf_range(spawn_position_begin.y, spawn_position_end.y) 

	return Vector2(x_pos, y_pos)


func _on_timer_timeout() -> void:
	time += 1
	for wave_info in current_wave_info:
		if wave_info.spawn_delay_counter < wave_info.spawn_delay:
			wave_info.spawn_delay_counter += 1
		else:
			wave_info.spawn_delay_counter = 0
			_spawn_enemies(wave_info)
