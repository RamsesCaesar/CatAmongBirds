extends Node2D

onready var heart = preload("res://Collectibles/Heart.tscn")

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

var randomizer

func _ready():
	randomizer = RandomNumberGenerator.new()

func create_grass_effect():
	var grassEffect = GrassEffect.instance()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position

func _on_HurtBox_area_entered(area):
	create_grass_effect()
	randomizer.randomize()
	var randomNumber = randomizer.randi_range(0,6)
	if randomNumber == 0:
		var newHeart = heart.instance()
		newHeart.global_position = global_position
		get_tree().current_scene.add_child(newHeart)
	queue_free()
