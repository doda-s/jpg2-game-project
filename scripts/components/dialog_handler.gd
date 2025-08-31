extends Node2D
class_name DialogHandler

@export_file("*.json") var dialog_json_file: String
@export var context = ""

var _interactable_component: InteractableComponent

@onready var _dialog_scoop = {}

func _ready() -> void:
	_interactable_component = get_parent().get_node('InteractableComponent')
	
	if InteractableComponent == null:
		push_error("DialogHandler needs a interactable component.")
	
	if not _interactable_component.interaction_emitter.is_connected(_init_dialog):
		_interactable_component.interaction_emitter.connect(_init_dialog)

func _init_dialog() -> void:
	_dialog_scoop = _load_dialog_json()
	print(_dialog_scoop.text)

func _load_dialog_json():
	if not FileAccess.file_exists(dialog_json_file):
		print_debug("Dialog file not exist.")
		return
	
	return JSON.parse_string(FileAccess.open(dialog_json_file, FileAccess.READ).get_as_text())
