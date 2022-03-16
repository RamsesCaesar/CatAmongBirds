extends Node2D

onready var timer = $Timer
signal stop_music

func _on_Timer_timeout():
	$AudioStreamPlayer.play()


func _on_VictoryScreen_visibility_changed():
	emit_signal("stop_music")
	timer.start(0.5)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if self.visible else Input.MOUSE_MODE_HIDDEN)
