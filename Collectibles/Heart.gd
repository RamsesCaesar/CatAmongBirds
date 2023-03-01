extends AnimatedSprite

var stats = PlayerStats

func _on_Area2D_area_entered(area):
	if area.name == "ItemSnatcher" and stats.health < stats.max_health:
		stats.set_health(stats.health + 1)
		get_tree().current_scene.get_node("WorldSounds").play()
		queue_free()
