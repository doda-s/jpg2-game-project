extends DialogView

class_name CaseDialogView

func _ready() -> void:
	title_text_reach = get_node('Background/ScrollContainer/VBoxContainer/Title')
	text_text_reach = get_node('Background/ScrollContainer/VBoxContainer/Text')
	options_vbox = get_node('Background/ScrollContainer/VBoxContainer/Options')
	
	if title_text_reach == null:
		push_error("DialogView component is missing title TextTeach.")
	if text_text_reach == null:
		push_error("DialogView component is missing text TextReach.")
	if options_vbox == null:
		push_error("DialogView component is missing title VBoxContainer.")
	
	DialogHandler.set_dialog_view(self)