extends "res://Enemies/Bird.gd"

func _ready():
	stats.set_max_health(8)
	stats.set_health(8)

func _physics_process(delta):
	if playerDetectionZone.can_see_player():
		$AnimatedSprite.animation = "Angry"
	else: 
		match state: 
			IDLE:
				$AnimatedSprite.set("animation", "Standing")
			WANDER:
				$AnimatedSprite.set("animation", "Walking")
			CHASE:
				$AnimatedSprite.set("animation", "Walking")

