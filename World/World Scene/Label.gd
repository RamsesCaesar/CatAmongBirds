extends Label

func _process(delta):
	self.text = "Birds: " + str(PlayerStats.bats)
