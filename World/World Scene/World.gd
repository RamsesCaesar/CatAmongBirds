extends Node2D

export(bool) var debug_mode = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	if Input.is_action_just_pressed("debug_kill") and debug_mode:
		var killList = get_node("YSort/Bats").get_children()
		for node in killList:
			node.get_node("Stats").set_health(0)
	if Input.is_action_just_pressed("ui_cancel"):
		$CanvasLayer/InGameMenu.visible = !$CanvasLayer/InGameMenu.visible
		get_tree().paused = true if $CanvasLayer/InGameMenu.visible else false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if $CanvasLayer/InGameMenu.visible else Input.MOUSE_MODE_HIDDEN)
		

func _on_InGameMenu_toggle_music():
	$WorldMusic.playing = !$WorldMusic.playing


func _on_VictoryScreen_stop_music():
	$WorldMusic.stop()


func _on_DefeatScreen_stop_music():
	$WorldMusic.stop()
