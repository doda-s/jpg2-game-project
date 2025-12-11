extends Node2D

func _ready() -> void:
	SceneSwitcher.current_scene = self
	if not DialogHandler.dialog_ended_signal.is_connected(teste):
		DialogHandler.dialog_ended_signal.connect(teste)


func teste(_arr):
	Globals.ResponseArr.clear()
	Globals.ResponseArr.append_array(_arr)
	SceneSwitcher.switch_scene("res://scenes/demos/final_scene.tscn")