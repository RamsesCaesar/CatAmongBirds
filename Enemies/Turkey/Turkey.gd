extends "res://Enemies/Bird.gd"

func _ready():
	stats.set_max_health(4)
	stats.set_health(4)

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

