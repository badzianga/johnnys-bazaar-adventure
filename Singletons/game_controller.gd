extends Node


const WAVE_TIMES: Array[int] = [0, 3, 60, 60, 60, 60, 60, 60, 60, 60, 60]
const music_streams := {
	&"bazaar": preload("res://Assets/Music/istanbul-dreams.mp3"),
	&"wave": preload("res://Assets/Music/belly-dance.mp3"),
	&"wave10": preload("res://Assets/Music/arabian-trap-powerful.mp3"),
}
const BazaarScene := preload("res://Scenes/Bazaar/bazaar.tscn")
const WorldScene := preload("res://Scenes/World/test_world.tscn")
const ResultScreenScene := preload("res://Scenes/ResultScreen/result_screen.tscn")
const IntroScene := preload("res://Scenes/Intro/intro.tscn")

var current_wave := 1
var coins := 0
var player: CharacterBody2D
var enemies: Array[Enemy]
var purchased_upgrades: Array[StringName] = [""]
var coins_left := 0

@onready var timer := $Timer
@onready var music_player := $MusicPlayer


func _ready() -> void:
	randomize()


func show_intro() -> void:
	get_tree().change_scene_to_packed(IntroScene)


func play_music(title: StringName) -> void:
	music_player.stream = music_streams[title]
	music_player.play()


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
			PlayerUpgrades.djeds += 1
		3:
			PlayerUpgrades.djed_extra_damage += 5
			PlayerUpgrades.djed_cooldown_multiplier -= 0.08
		4:
			PlayerUpgrades.djed_extra_damage += 10
			PlayerUpgrades.djed_penetration += 1
			PlayerUpgrades.djed_extra_bullets += 1
		5:
			PlayerUpgrades.djed_penetration += 1
			PlayerUpgrades.djed_damage_multiplier += 0.1
			PlayerUpgrades.djed_cooldown_multiplier -= 0.08
		6:
			PlayerUpgrades.extra_damage += 5
		7:
			PlayerUpgrades.extra_damage += 10
		8:
			PlayerUpgrades.extra_damage += 10
		9:
			PlayerUpgrades.cooldown_reduce_sec += 0.15
		10:
			PlayerUpgrades.cooldown_reduce_sec += 0.1
		11:
			PlayerUpgrades.cooldown_reduce_sec += 0.2
		12:
			PlayerUpgrades.extra_bullets += 1
			PlayerUpgrades.penetration += 1
		13:
			PlayerUpgrades.extra_bullets += 1
			PlayerUpgrades.penetration += 1
		14:
			PlayerUpgrades.max_health += 5
			PlayerUpgrades.speed_multiplier += 0.05
		15:
			PlayerUpgrades.max_health += 8
			PlayerUpgrades.speed_multiplier += 0.1
		16:
			PlayerUpgrades.max_health += 10
		17:
			PlayerUpgrades.damage_multiplier += 0.08
			PlayerUpgrades.djed_damage_multiplier += 0.08
			PlayerUpgrades.bullet_speed_multiplier += 0.15
			PlayerUpgrades.djed_bullet_speed_multiplier += 0.15
			PlayerUpgrades.cooldown_multiplier -= 0.08
			PlayerUpgrades.djed_cooldown_multiplier -= 0.08
		18:
			PlayerUpgrades.damage_multiplier += 0.08
			PlayerUpgrades.djed_damage_multiplier += 0.08
			PlayerUpgrades.bullet_speed_multiplier += 0.15
			PlayerUpgrades.djed_bullet_speed_multiplier += 0.15
			PlayerUpgrades.cooldown_multiplier -= 0.08
			PlayerUpgrades.djed_cooldown_multiplier -= 0.08
		19:
			PlayerUpgrades.djed_damage_multiplier += 0.15
			PlayerUpgrades.djed_penetration += 1
		20:
			PlayerUpgrades.damage_multiplier += 0.15
			PlayerUpgrades.penetration += 1


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
	timer.stop()
	current_wave = 1
	coins = 0
	coins_left = 0
	player = null
	PlayerUpgrades.reset()
	Upgrades.push_upgrades()
	purchased_upgrades.clear()
	purchased_upgrades.append("")
	back_to_world()


func _retrieve_coins_left() -> void:
	coins_left = get_tree().get_first_node_in_group("Loot").get_child_count()


func _on_timer_timeout() -> void:
	_retrieve_coins_left()

	current_wave += 1
	if current_wave >= len(WAVE_TIMES):
		go_to_result_screen()
		return
	# go to bazaar
	timer.stop()
	coins = player.coins
	Hud.visible = false
	get_tree().change_scene_to_packed(BazaarScene)
