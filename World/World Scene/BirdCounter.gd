extends Label

func _process(delta):
	self.text = "Birds: " + str(PlayerStats.birds) + "\n" + "Coins: " + str(PlayerStats.coins)


