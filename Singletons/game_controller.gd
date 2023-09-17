extends Node


const WAVE_TIMES: Array[int] = [0, 100, 5, 10, 10, 20]
const BazaarScene := preload("res://Scenes/Bazaar/bazaar.tscn")
const WorldScene := preload("res://Scenes/World/test_world.tscn")

var current_wave := 1
var player: CharacterBody2D

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
	_reset_timer()


func _on_timer_timeout() -> void:
	current_wave += 1
	get_tree().change_scene_to_packed(BazaarScene)
