extends CanvasLayer


const WorldScene := preload("res://Scenes/World/test_world.tscn")
const textures: Array[CompressedTexture2D] = [
	preload("res://Assets/Placeholders/1.jpg"),
	preload("res://Assets/Placeholders/2.jpg"),
	preload("res://Assets/Placeholders/3.jpg"),
	preload("res://Assets/Placeholders/4.jpg"),
	preload("res://Assets/Placeholders/5.jpg"),
]

@onready var skip_ad := $SkipAd
@onready var timer := $Timer


func _ready() -> void:
	$TextureRect.texture = textures.pick_random()


func _process(_delta: float) -> void:
	if not timer.is_stopped():
		skip_ad.text = "You can skip ad in " + str(ceil(timer.time_left))


func _on_timer_timeout() -> void:
	skip_ad.text = "Skip ad"
	$Button.visible = true


func _on_button_pressed() -> void:
	GameController.back_to_world()
