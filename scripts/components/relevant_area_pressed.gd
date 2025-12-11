extends Node2D

class_name RelevantAreaController

signal get_current_area

var mouse_in: bool
var current_select_area: String

func _ready():
	add_to_group("relevant_area_controller")
	var all = get_tree().get_nodes_in_group("relevant_area_group")
	for child: RelevantArea in all:
		if Globals.relevant_area_list.find(child.area_group) == -1:
			Globals.relevant_area_list.append(child.area_group)

		if (child is RelevantArea):
			child.connect("on_mouse_entered", Callable(self, "_on_child_mouse_entered"))
			child.connect("on_mouse_exited", Callable(self, "_on_child_mouse_exited"))
	
func _process(delta):
	if !mouse_in: return
	
	if int(Input.is_action_just_pressed("mouse_click")):
		emit_signal("get_current_area", current_select_area)
		var all = get_tree().get_nodes_in_group("relevant_area_group")
		for area in all:
			if (area.area_group == current_select_area):
				print(area.area_group)
				if (area.has_method("change_visibility")):
					area.change_visibility(true)
				if (area.has_method("change_text_visibility")):
					area.change_text_visibility(true)

func _on_child_mouse_entered(area_name: String):
	if (area_name == ""):
		printerr("Current selected area group not defined!")
		return

	current_select_area = area_name
	mouse_in = true

func _on_child_mouse_exited():
	current_select_area = ""
	mouse_in = false
