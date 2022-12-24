extends Node
#____VARIABLES:
const victoryScreen = preload("res://UI/Menus and Pop Ups/VictoryScreen.tscn")
export(int) var max_health = 1 setget set_max_health
var             health = max_health setget set_health
var             birds = 0 setget set_birds, get_birds
var             coins = 0 setget set_coins, get_coins

enum coat {
	ORANGE,
	WHITE,
	TABBY
}

#____SIGNALS: 
signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal birds_number_changed(value)
signal coins_collected_number_changed(value)
#____READY:_______________________________________________________________________
func _ready(): 
	self.health = max_health
#____HEALTH SETTERS:______________________________________________________________
func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)
func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
#____BAT SET GET:_________________________________________________________________
func set_birds(value):
	birds = value
	emit_signal("birds_number_changed", value)
	if birds <= 0 and get_tree().current_scene.name == "World":
		get_tree().current_scene.get_node("CanvasLayer/VictoryScreen").show()
		pass
func get_birds():
	return birds
# COINS SETGET
func set_coins(value):
	coins = value
	emit_signal("coins_collected_number_changed", value)
func get_coins():
	return coins

