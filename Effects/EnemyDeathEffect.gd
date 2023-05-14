extends AnimatedSprite

enum effect_state{
	default,
	implosion_finished,
	explosion_finished
}

var state = effect_state.default

func _ready():
	self.connect("animation_finished", self, "_on_animation_finished")
	frame = 0
	#play("Animate")
	# Testing making my own effect animation:
	# (RamsesCaesar, 2023-05-03 22:20)
	play("Implosion")
	state = effect_state.implosion_finished	

func _on_animation_finished():
	match state:
		effect_state.implosion_finished:
			play("Explosion")
			state = effect_state.explosion_finished
		effect_state.explosion_finished:
			queue_free()
