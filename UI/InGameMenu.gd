extends Node2D

var music = false
signal toggle_music
func _ready():
	adjustMusicButton()

func _on_ToggleMusicButton_pressed():
	music = !music
	adjustMusicButton()
	emit_signal("toggle_music")

func adjustMusicButton():
	match music:
		true: $Control/ToggleMusicButton/AnimatedSprite.animation = "YES"
		false: $Control/ToggleMusicButton/AnimatedSprite.animation = "NO"
