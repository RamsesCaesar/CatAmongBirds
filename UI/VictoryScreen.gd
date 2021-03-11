extends Node2D

onready var timer = $Timer

func _ready():
	timer.start(0.5)
	


func _on_Timer_timeout():
	get_node("AudioStreamPlayer").play()
