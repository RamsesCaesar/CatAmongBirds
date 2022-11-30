extends Node2D

signal stop_music

func _on_DefeatScreen_visibility_changed():
	emit_signal("stop_music")
	$AudioStreamPlayer.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if self.visible else Input.MOUSE_MODE_HIDDEN)
