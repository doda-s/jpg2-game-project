extends Node2D

class_name dragAndDrop

var grab_object_stack = []

# exemplo de como poderam ser inicializados
func _ready():
	var grabable_object_list = get_tree().get_nodes_in_group("grabbable_objects_group")
	# adiciona items grabable na lista de ordenação
	for obj in grabable_object_list:
		add_grab_object(obj)

func add_grab_object(grab_object):
	grab_object_stack.append(grab_object)
	
	var count = 0
	for object in grab_object_stack:
		object.z_index = count
		
		count += 1

func push_paper_to_top(grab_object):
	grab_object_stack.erase(grab_object)
	add_grab_object(grab_object)
