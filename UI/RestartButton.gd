extends TextureButton

func _pressed():
	PlayerStats.set_bats(0)
	get_tree().reload_current_scene()
	
