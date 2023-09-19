extends Node


const WAVE_TIMES: Array[int] = [0, 30, 30, 35, 40, 50]
const BazaarScene := preload("res://Scenes/Bazaar/bazaar.tscn")
const WorldScene := preload("res://Scenes/World/test_world.tscn")
const ResultScreenScene := preload("res://Scenes/ResultScreen/result_screen.tscn")

var current_wave := 1
var coins := 999
var player: CharacterBody2D
var enemies: Array[Enemy]
var purchased_upgrades: Array[StringName]

@onready var timer := $Timer
@onready var music_player := $MusicPlayer


func _ready() -> void:
	Hud.set_wave(current_wave)
	randomize()
	_reset_timer()


func _process(_delta: float) -> void:
	Hud.set_time(ceil(timer.time_left))


func _reset_timer() -> void:
	timer.wait_time = WAVE_TIMES[current_wave]
	timer.start()


func back_to_world() -> void:
	enemies.clear()
	get_tree().change_scene_to_packed(WorldScene)
	Hud.set_wave(current_wave)
	Hud.visible = true
	_reset_timer()


func upgrade_character(item_id: int) -> void:
	# WARNING! Stupid code, ignore that please
	match item_id:
		0:
			PlayerUpgrades.djeds += 1
		1:
			PlayerUpgrades.djeds += 1
		2:
			PlayerUpgrades.extra_damage += 5
		3:
			PlayerUpgrades.extra_damage += 10
		4:
			PlayerUpgrades.extra_damage += 15
		5:
			PlayerUpgrades.cooldown_reduce_sec += 0.1
		6:
			PlayerUpgrades.extra_bullets += 1
		7:
			PlayerUpgrades.max_health += 5


func remove_available_upgrade(item_id: int) -> void:
	var index := 0
	for item_data in Upgrades.available_upgrades:
		if item_data["Id"] == item_id:
			Upgrades.available_upgrades.remove_at(index)
			break
		index += 1


func go_to_result_screen() -> void:
	timer.stop()
	Hud.visible = false
	get_tree().change_scene_to_packed(ResultScreenScene)


func reset_game() -> void:
	current_wave = 1
	coins = 0
	player = null
	purchased_upgrades.clear()
	back_to_world()
	


func _on_timer_timeout() -> void:
	current_wave += 1
	if current_wave >= len(WAVE_TIMES):
		go_to_result_screen()
	# go to bazaar
	coins = player.coins
	Hud.visible = false
	get_tree().change_scene_to_packed(BazaarScene)
