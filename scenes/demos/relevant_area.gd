extends Area2D

class_name RelevantArea

signal on_mouse_entered
signal on_mouse_exited

@export var areaGroup: String

func _ready():
	add_to_group("relevant_area_group")
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	emit_signal("on_mouse_entered", areaGroup)

func _on_mouse_exited():
	emit_signal("on_mouse_exited")

func change_visibility():
	for child in get_children():
		if (child is ColorRect):
			child.visible = !child.visible
		pass
