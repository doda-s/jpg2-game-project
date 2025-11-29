extends Area2D

class_name RelevantArea

signal on_mouse_entered
signal on_mouse_exited

@export var area_group: String
@export var correct_answer_msg: String
@export var wrong_answer_msg: String

func _ready():
	add_to_group("relevant_area_group")
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	emit_signal("on_mouse_entered", area_group)

func _on_mouse_exited():
	emit_signal("on_mouse_exited")

func change_visibility(state: bool):
	for child in get_children():
		if (child is ColorRect):
			child.visible = state
