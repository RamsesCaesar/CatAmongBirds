extends Node
#____VARIABLES:
const victoryScreen = preload("res://UI/VictoryScreen.tscn")
export(int) var max_health = 1 setget set_max_health
var health = max_health setget set_health
var bats = 0 setget set_bats, get_bats
#____SIGNALS: 
signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal bats_changed(value)
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
func set_bats(value):
	bats = value
	emit_signal("bats_changed", bats)
	if bats <= 0:
		get_tree().current_scene.get_node("CanvasLayer").add_child(victoryScreen.instance())
		pass
func get_bats():
	return bats

