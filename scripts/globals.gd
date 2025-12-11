extends Node

var target_scene_path = ''
var target_door_id = ''
var response_final_list = []
var ResponseArr = []
var relevant_area_list = []

var obj_dialog = {}

func set_dialog_obj(dictionary: Dictionary):
	obj_dialog = dictionary
	
func transport_to_target():
	var player = get_tree().root.find_child("Player", true, false)
	var doors = get_tree().get_nodes_in_group("doors")
	for d in doors:
		if d is Node2D and d.door_id == target_door_id:
			player.global_position = d.global_position + Vector2(0, 50)
			return



var stack: Array = []
var current_scene: Node = null

func push(scene_path: String):
	# Guarda a cena atual (se existir)
	if current_scene:
		stack.append(current_scene)
		get_tree().root.remove_child(current_scene)

	# Instancia a nova cena
	var new_scene = load(scene_path).instantiate()
	get_tree().root.add_child(new_scene)
	current_scene = new_scene


func pop():
	if stack.is_empty():
		return # Nada pra voltar

	# Remove e destrói a cena atual
	get_tree().root.remove_child(current_scene)
	current_scene.queue_free()

	# Recupera a cena anterior
	current_scene = stack.pop_back()
	get_tree().root.add_child(current_scene)
