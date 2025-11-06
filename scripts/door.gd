extends Node2D

@export var door_id : String
@export var target_id : String = '1'
@export var target_scene_path: String 
var player_can_interact = false

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_can_interact = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_can_interact = false

func _ready():
	Globals.transport_to_target()
	
func _process(delta):
	if player_can_interact and Input.is_action_just_pressed("interact"):
		Globals.target_door_id = target_id
		Globals.transport_to_target()
		if target_scene_path != null:
			get_tree().call_deferred("change_scene_to_file", target_scene_path)
