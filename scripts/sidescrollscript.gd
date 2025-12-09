extends Node2D

func _ready():
	Globals.current_scene = self
	if not DialogHandler.dialog_ended_signal.is_connected(teste):
		DialogHandler.dialog_ended_signal.connect(teste)

func _on_button_pressed() -> void:
	Globals.push("res://scenes/demos/final_scene.tscn")

func teste(_arr):
	Globals.ResponseArr.clear()
	Globals.ResponseArr.append_array(_arr)
	Globals.push("res://scenes/demos/final_scene.tscn")

	
