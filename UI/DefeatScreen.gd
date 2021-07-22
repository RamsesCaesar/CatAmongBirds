extends Node2D



func _on_DefeatScreen_visibility_changed():
	$AudioStreamPlayer.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if self.visible else Input.MOUSE_MODE_HIDDEN)
