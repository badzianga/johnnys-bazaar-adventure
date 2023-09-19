extends Node


const WAVE_TIMES: Array[int] = [0, 30, 30, 35, 40, 50]
const BazaarScene := preload("res://Scenes/Bazaar/bazaar.tscn")
const WorldScene := preload("res://Scenes/World/test_world.tscn")

var current_wave := 1
var coins := 0
var player: CharacterBody2D
var enemies: Array[Enemy]

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
	get_tree().change_scene_to_packed(WorldScene)
	Hud.set_wave(current_wave)
	Hud.visible = true
	_reset_timer()


func _on_timer_timeout() -> void:
	# go to bazaar
	current_wave += 1
	coins = player.coins
	Hud.visible = false
	get_tree().change_scene_to_packed(BazaarScene)
