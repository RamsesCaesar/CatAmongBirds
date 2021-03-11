extends Button

func _pressed():
	PlayerStats.set_bats(0)
	PlayerStats.set_health(4)
	get_tree().change_scene("res://World.tscn")
