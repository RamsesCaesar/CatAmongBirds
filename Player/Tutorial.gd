extends Control

# Counter for tutorial:
var tutorial_stage = 0 setget set_stage, get_stage
var tutorial_bools = {}

func _ready():
	pass

func _process(delta):
	match tutorial_stage:
		0:
			if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
				set_stage(1)
		1:
			if Input.is_action_just_pressed("attack"):
				set_stage(2)
		2:
			if Input.is_action_just_pressed("sprint"):
				set_stage(3)
		3:
			queue_free()
	pass

func set_stage(input):
	tutorial_stage = input
	match input:
		1:
			if tutorial_bools["MoveTutorial"] == true:
				$MoveTutorial.queue_free() 
			if tutorial_bools["SwatTutorial"] == true:
				$SwatTutorial.show() 

		2:
			if tutorial_bools["SwatTutorial"] == true:
				$SwatTutorial.queue_free() 
			if tutorial_bools["DashTutorial"] == true:
				$DashTutorial.show()
		3:
			if tutorial_bools["DashTutorial"] == true:
				$DashTutorial.queue_free()


func get_stage():
	return tutorial_stage
	
