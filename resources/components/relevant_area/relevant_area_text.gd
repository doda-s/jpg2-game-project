extends Node2D

@export var areaGroup: String


func _ready():
	add_to_group("relevant_area_group")

func change_text_visibility(state: bool):
	$Label.visible = state
