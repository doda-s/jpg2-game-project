extends Node

var target_scene_path = ''
var target_door_id = ''

func transport_to_target():
	var player = get_tree().root.find_child("Player", true, false)
	var doors = get_tree().get_nodes_in_group("doors")
	for d in doors:
		if d is Node2D and d.door_id == target_door_id:
			player.global_position = d.global_position + Vector2(0, 50)
			return
