extends Node2D

class_name RelevantAreaController

var mouse_in: bool
var currentSelectArea: String

func _process(delta):
	if !mouse_in: return
	
	if int(Input.is_action_just_pressed("mouse_click")):
		print("clicou: ", currentSelectArea)
		var all = get_tree().get_nodes_in_group("relevant_area_group")
		for area in all:
			if (area.areaGroup == currentSelectArea):
				print(area.areaGroup)
				if (area.has_method("change_visibility")):
					print("entrou no change_visibility")
					area.change_visibility(true)
				if (area.has_method("change_text_visibility")):
					print("entrou no change_text_visibility")
					area.change_text_visibility(true)

func _ready():
	var all = get_tree().get_nodes_in_group("relevant_area_group")
	for child in all:
		if (child is RelevantArea):
			child.connect("on_mouse_entered", Callable(self, "_on_child_mouse_entered"))
			child.connect("on_mouse_exited", Callable(self, "_on_child_mouse_exited"))

func _on_child_mouse_entered(areaName: String):
	if (areaName == ""):
		printerr("Current selected area group not defined!")
		return

	currentSelectArea = areaName
	print("areaName: ", areaName)
	mouse_in = true
	print(mouse_in)

func _on_child_mouse_exited():
	currentSelectArea = ""
	mouse_in = false
