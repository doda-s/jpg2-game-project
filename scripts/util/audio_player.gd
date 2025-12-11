extends AudioStreamPlayer

var music_village = load("res://assets/music/long_tail_blue.mp3")

func set_music_config(music: AudioStream = null, volume: float = 0.5):
	if music == null:
		music = get_current_music()

	if stream != music:
		_set_current_music_and_play(music)

	_set_volume(linear_to_db(volume))

func _set_volume(db_value: float):
	volume_db = db_value

func _set_current_music_and_play(music: AudioStream):
	stream = music
	play()

func get_current_music():
	return stream
