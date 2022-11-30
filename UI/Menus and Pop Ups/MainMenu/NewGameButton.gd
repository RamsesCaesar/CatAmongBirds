extends TextureButton

func _input(event):
	if event is InputEventKey and event.pressed:
		grab_focus()

func _on_NewGameButton_pressed():
	get_tree().change_scene("res://World/World Scene/World.tscn")
	PlayerStats.set_birds(0)
	PlayerStats.set_health(4)
