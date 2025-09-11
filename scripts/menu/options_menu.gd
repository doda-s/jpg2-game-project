extends Control

@export var menu_music: AudioStream

func _ready():
	AudioPlayer.set_music_config(menu_music)

func _on_return_button_down():
	SceneSwitcher.switch_scene("res://menu/start_menu.tscn")
