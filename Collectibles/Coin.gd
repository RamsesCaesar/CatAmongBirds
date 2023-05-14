extends AnimatedSprite

var stats = PlayerStats

func _ready():
	add_to_group("coins")

func _on_Area2D_area_entered(area):
	if area.name == "ItemSnatcher":
		stats.set_coins(stats.coins + 1)
		get_tree().current_scene.get_node("WorldSounds").play()
		get_tree().current_scene.coins_icon_lightup()
		queue_free()
