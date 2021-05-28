extends Node2D

onready var timer = $Timer

func _on_Timer_timeout():
	$AudioStreamPlayer.play()


func _on_VictoryScreen_visibility_changed():
	timer.start(0.5)
