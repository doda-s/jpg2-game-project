extends CharacterBody2D
class_name Player

var _moviment_component: MovimentComponent
var _player_controller_component: PlayerControllerComponent
var _sprite: AnimatedSprite2D

func _ready() -> void:
	_moviment_component = get_node('MovimentComponent')
	_player_controller_component = get_node('PlayerControllerComponent')
	_sprite = get_node("AnimatedSprite2D")
	
	if _moviment_component == null:
		printerr("The player scene needs a MovimentComponent node.")
	if _player_controller_component == null:
		printerr("The player scene needs a PlayerControllerComponent node.")
	if _sprite == null:
		printerr("The player scene needs a AnimatedSprite2D node.")

func _physics_process(_delta: float) -> void:
	_player_controller_component.interact()
	
	# Avoid null exceptions
	if _moviment_component == null:
		return
	if _player_controller_component == null:
		return
	
	var _h_axis: float = _player_controller_component.horizontal_axis()
	var _jump: float = _player_controller_component.jump()
	var _moviment_direction: Vector2 = Vector2(_h_axis, _jump)
	
	_moviment_component.moviment_direction(_moviment_direction)
	_moviment_component.move(_delta) # Contains move_and_slide() 

	if not _moviment_direction.x == 0:
		_sprite.play("walking")
	else:
		_sprite.play("idle")

	if _moviment_direction.x < 0:
		_sprite.flip_h = true
	elif _moviment_direction.x > 0:
		_sprite.flip_h = false
