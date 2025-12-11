extends Node2D

@export var scene: String = ""

func _on_interactable_component_interaction_emitter():
	if scene == "":
		printerr("tem porr nenhuma")
		return
	SceneSwitcher.switch_scene(scene)
