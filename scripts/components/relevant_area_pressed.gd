extends Node2D

class_name RelevantAreaController

var mouse_in: bool
var currentSelectArea: String

func _process(delta):
	if !mouse_in: return
	

	if int(Input.is_action_just_pressed("mouse_click")):
		print("clicou: ", currentSelectArea)
		var all = get_tree().get_nodes_in_group("relevant_area_group")
		for area: RelevantArea in all:
			if (area.areaGroup == currentSelectArea):
				print(area.areaGroup)
				change_area_visibility(area)
			

func _ready():
	var all = get_tree().get_nodes_in_group("relevant_area_group")
	for child in all:
		child.connect("on_mouse_entered", Callable(self, "_on_child_mouse_entered"))
		child.connect("on_mouse_exited", Callable(self, "_on_child_mouse_exited"))
	
func change_area_visibility(area: RelevantArea):
	area.change_visibility()

func _on_child_mouse_entered(areaName: String):
	if (areaName == ""):
		printerr("Current selected area group not defined!")
		return

	currentSelectArea = areaName
	mouse_in = true
	print("_on_child_mouse_entered")
	pass

func _on_child_mouse_exited():
	currentSelectArea = ""
	mouse_in = false
	print("_on_child_mouse_exited")
	pass
