extends Node2D

var music = true
signal toggle_music
func _ready():
	pass # Replace with function body.

func _on_TextureButton_pressed():
	music = !music
	match music:
		true: $Control/TextureButton/AnimatedSprite.animation = "YES"
		false: $Control/TextureButton/AnimatedSprite.animation = "NO"
	emit_signal("toggle_music")
