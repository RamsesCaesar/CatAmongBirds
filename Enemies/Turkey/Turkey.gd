extends "res://Enemies/Bird.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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

