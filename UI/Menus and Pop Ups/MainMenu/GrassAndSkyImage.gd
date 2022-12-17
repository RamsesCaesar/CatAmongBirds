extends ParallaxLayer

export(float) var scroll_speed = -15

func _process(delta):
	self.motion_offset.x += scroll_speed * delta
	# Credits for this function go to this YouTube video:
	# https://www.youtube.com/watch?v=f8z4x6R7OSM
