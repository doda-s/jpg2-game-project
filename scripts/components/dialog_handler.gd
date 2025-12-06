extends Node2D

signal dialog_ended_signal(player_choice_mapping: Array[int])

# The DialogManager is responsible for managing the dialog nodes of a context.
# This context is received through a DialogHandler.

var _current_dialog: String
var _dialogs: Array
var _dialog_node_count: int
var _dialog_view: DialogView
var _start_in: String
var _end_in: String
var _player_choice_mapping: Array[int]

func set_dialog_view(_dialog_view_obj: DialogView):
	_dialog_view = _dialog_view_obj

func init_dialog(ctx: Dictionary) -> void:
	# Initializes and prepares dialog nodes
	_current_dialog = ""
	_dialog_node_count = ctx.DialogNodes.size()
	_dialogs = ctx.DialogNodes
	_start_in = ctx.StartIn
	_end_in = ctx.EndIn
	_player_choice_mapping = []
	next_dialog(_start_in)

func next_dialog(_dialog_node_id: String, choice_index: int = -1) -> void:
	if choice_index >= 0:
		_player_choice_mapping.append(choice_index)
	
	if _current_dialog == _end_in:
		_debug({}, _player_choice_mapping)
		_dialog_view.close_dialog()
		dialog_ended_signal.emit(_player_choice_mapping)
		return
	
	for _node in _dialogs:
		if _node.ID == _dialog_node_id:
			_debug(_node, [])
			_dialog_view.show_dialog(_node)
			_current_dialog = _node.ID
			break

	_debug({}, _player_choice_mapping)

func _debug(node := {}, player_choice_mapping := []) -> void:
	
	if not node.is_empty():
		print_debug(
			node.Title,
			node.Text,
			node.Options,
		)
	
	if not player_choice_mapping.is_empty():
		print_debug(player_choice_mapping)
