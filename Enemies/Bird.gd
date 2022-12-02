extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

enum {
	IDLE,
	WANDER,
	CHASE
}
# Constants for movement:
export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

# Variables for movement:
var velocity = Vector2.ZERO
var state = IDLE
var knockback = Vector2.ZERO

# Nodes:
onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $HurtBox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer

func _ready():
	state =  pick_random_state([IDLE, WANDER])
	PlayerStats.set_birds(PlayerStats.get_birds() + 1)

func _physics_process(delta):
	# 1. Handle knockback:
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	# 2. Handle state:
	match state: 
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				start_wandering()
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				start_wandering()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= 4:
				start_wandering()
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				# Accelerate toward the player's position, 
				# minus half the difference between the bird's position 
				# and the position of its hitbox. (hence "/-2" in the code).
				accelerate_towards_point((player.global_position + Vector2(0, $HitBox/CollisionShape2D.position.y  / -2)), delta)
			else:
				state = IDLE

	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func start_wandering():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))
	$AnimatedSprite.animation = "Normal"

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
		$AnimatedSprite.animation = "Angry"

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
	
func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 150
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.2)

func _on_Stats_no_health():
	get_tree().current_scene.bird_icon_lightup()
	PlayerStats.set_birds(PlayerStats.get_birds() - 1)
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	
func _on_HurtBox_invincibility_ended():
	animationPlayer.play("Stop")
	
func _on_HurtBox_invincibility_started():
	animationPlayer.play("Start")

