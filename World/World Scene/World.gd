extends Node2D

export(bool) var debug_mode = false
onready var bird_icon = $CanvasLayer/BirdSmallIcon
onready var coin_icon = $CanvasLayer/CoinSmallIcon

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
	
# UI LOGIC
const LIGHTUP_DURATION = 0.2 
# This method makes the bird counter icon light up when birds are killed
func bird_icon_lightup():
	print("bird_icon_lightup")
	bird_icon.play("lit") 
	yield(get_tree().create_timer(LIGHTUP_DURATION), "timeout")
	bird_icon.play("default")
# This method makes the coin counter light up when coins are collected
func coins_icon_lightup():
	print("coins_icon_lightup")
	coin_icon.play("lit")
	yield(get_tree().create_timer(LIGHTUP_DURATION), "timeout")
	coin_icon.play("default")
	
# END OF UI LOGIC
