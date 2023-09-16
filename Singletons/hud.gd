extends CanvasLayer


@onready var health_bar := $Control/HealthBar
@onready var time_label := $Control/TimeLabel
@onready var wave_label := $Control/WaveLabel


func set_health(health: int) -> void:
	health_bar.value = health


func set_max_health(max_health: int) -> void:
	health_bar.max_value = max_health


func set_time(time: int) -> void:
	time_label.text = str(time)


func set_wave(wave: int) -> void:
	wave_label.text = "Wave: " + str(wave)
