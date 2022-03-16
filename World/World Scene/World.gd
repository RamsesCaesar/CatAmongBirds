extends Node2D

const mainMenu = preload("res://UI/MainMenu.tscn")

export(bool) var debug_mode = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	if Input.is_action_just_pressed("debug_kill") and debug_mode:
		var killList = get_node("YSort/Bats").get_children()
		for node in killList:
			node.get_node("Stats").set_health(0)
	if Input.is_action_just_pressed("ui_cancel"):
		$CanvasLayer/MainMenu.visible = !$CanvasLayer/MainMenu.visible
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if $CanvasLayer/MainMenu.visible else Input.MOUSE_MODE_HIDDEN)
		

func _on_MainMenu_toggle_music():
	$WorldMusic.playing = !$WorldMusic.playing


func _on_VictoryScreen_stop_music():
	$WorldMusic.stop()
