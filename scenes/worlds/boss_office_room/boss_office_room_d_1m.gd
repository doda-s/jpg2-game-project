extends Node2D

func _ready():
	Globals.current_scene = self
	if not DialogHandler.dialog_ended_signal.is_connected(teste):
		DialogHandler.dialog_ended_signal.connect(teste)

func teste(_arr):
	SceneSwitcher.switch_scene("res://scenes/cases/first_case.tscn")