extends Node2D
class_name LookToPlayer

var player: CharacterBody2D
@export var sprite: AnimatedSprite2D

func _ready() -> void:
	if sprite ==  null:
		push_error("Missing sprite reference...")

	player = get_tree().current_scene.get_node("Player")
	if player == null:
		push_error("Missing player reference...")
		return

func _process(_delta: float) -> void:
	if global_position.x - player.global_position.x > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
