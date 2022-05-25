extends TextureButton

func _pressed():
	PlayerStats.set_birds(0)
	PlayerStats.set_health(4)
	get_tree().set_deferred("paused", false)
	get_tree().reload_current_scene()
	
