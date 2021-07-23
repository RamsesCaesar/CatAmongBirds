extends Label

func _process(delta):
	self.text = "Bats: " + str(PlayerStats.bats)
