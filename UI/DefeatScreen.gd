extends Node2D



func _on_DefeatScreen_visibility_changed():
	$AudioStreamPlayer.play()
