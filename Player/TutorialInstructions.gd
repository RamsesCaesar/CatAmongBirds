extends Label

func _ready():
	get_parent().tutorial_bools[self.name] = true


func _exit_tree():
	get_parent().tutorial_bools[self.name] = false


func _on_MoveTutorial_visibility_changed():
	yield(get_tree().create_timer(2.0),"timeout")
	queue_free()
