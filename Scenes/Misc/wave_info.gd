class_name WaveInfo
extends Resource


@export var wave_number: int
@export var enemy: PackedScene
@export var spawn_chance := 1.0
@export var amount: int
@export var spawn_delay: int

var spawn_delay_counter := 999
