extends Node2D

var music = true
signal toggle_music
func _ready():
	pass # Replace with function body.

func _on_ToggleMusicButton_pressed():
	music = !music
	match music:
		true: $Control/ToggleMusicButton/AnimatedSprite.animation = "YES"
		false: $Control/ToggleMusicButton/AnimatedSprite.animation = "NO"
	emit_signal("toggle_music")
