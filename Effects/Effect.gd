extends AnimatedSprite

func _ready():
	self.connect("animation_finished", self, "_on_animation_finished")
	frame = 0
	#play("Animate")
	# Testing making my own effect animation:
	# (RamsesCaesar, 2023-05-03 22:20)
	play("Prototype")

func _on_animation_finished():
	queue_free()
