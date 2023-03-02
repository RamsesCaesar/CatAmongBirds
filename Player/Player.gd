extends KinematicBody2D

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")
# TODO: Is it really the best design to have the DefeatScreen be a dependency
# of Player.tscn? (RamsesCaesar 2023-03-01 13:30)
const defeatScreen = preload("res://UI/Menus and Pop Ups/DefeatScreen.tscn")

export var ACCELERATION = 510
export var MAX_SPEED = 90
export var SPRINT_SPEED = 165
export var FRICTION = 600

enum {
	MOVE
	SPRINT
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var sprint_vector = Vector2.DOWN
# TODO: It's probably a good idea to review the singleton "Stats.gd" and see if
# 	it really is needed for this game. I have the suspicion that it's problematic 
# 	code. (RamsesCaesar 2023-03-01 13:34)
# This suspicion proves to be right when one compares what HeartBeast says in his 
# 	video on which this game is based on: https://youtu.be/1MO8DtnxSQs?t=47
# 	(RamsesCaesar 2023-03-02 19:54)
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $"HitBoxPivot/Sword-Hitbox"
onready var hurtbox = $HurtBox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

# When the player scene is instantiated:
func _ready():
	randomize()
	stats.connect("no_health", self, "death")
	animationTree.active = true
	swordHitbox.knockback_vector = sprint_vector
	# Disable hitbox because it can easily be wrongfully activated in the 
	# editor:
	$"HitBoxPivot/Sword-Hitbox/CollisionShape2D".disabled = true
	# Disable the blinkAnimationPlayer if the game is restarted:
	blinkAnimationPlayer.play("Stop")
	
# When the player dies:
func death():
	queue_free()
	get_tree().current_scene.get_node("CanvasLayer/DefeatScreen").show()

# Every frame:
func _process(delta):
	match state:
		MOVE:
			move_state(delta)
		SPRINT:
			sprint_state()
		ATTACK:
			attack_state()

# Movement:
func move_state(delta):
	var input_vector = determine_input_vector()
	# Acceleration:
	if input_vector != Vector2.ZERO:
		sprint_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		set_animation_tree_direction(input_vector)
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		animationState.travel("Run")
	# Stopping:
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	# Sprinting and Attacking:
	if Input.is_action_just_pressed("sprint"):
		state = SPRINT
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	move()
# Attack:
func attack_state():
	animationState.travel("Attack")
# Sprint:
func sprint_state():
	velocity = sprint_vector * SPRINT_SPEED
	animationState.travel("Sprint")
	move()

# The move() function takes all the calculations that were made 
# for the "velocity" variable and performs the movement of the Player scene
# on top of its parent scene.
func move():
	velocity = move_and_slide(velocity)

# This function is called by $AnimationPlayer when one 
# of the attack animations finishes. (This is a mechanism that gets set with 
# the Godot editor rather than here in the code).
func attack_animation_finished():
	state = MOVE
# This, too, is a function that gets called by $AnimationPlayer in the editor.
func sprint_animation_finished():
	velocity *= 0.8
	state = MOVE


func _on_HurtBox_area_entered(area):
	# Deduct health point(s)
	stats.health -= area.damage
	# Start temporary invincibility.
	hurtbox.start_invincibility(1)
	hurtbox.create_hit_effect()
	# Make a meow sound every second time the player (cat) takes damage.
	if stats.health % 2 == 0:
		var playerHurtsound = PlayerHurtSound.instance()
		get_tree().current_scene.add_child(playerHurtsound)


func _on_HurtBox_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_HurtBox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")
	
func determine_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	return input_vector
	
func set_animation_tree_direction(input_vector):
	animationTree.set("parameters/Idle/blend_position", input_vector)
	animationTree.set("parameters/Run/blend_position", input_vector)
	animationTree.set("parameters/Attack/blend_position", input_vector)
	animationTree.set("parameters/Sprint/blend_position", input_vector)
