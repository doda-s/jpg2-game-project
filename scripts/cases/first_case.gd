extends Node2D

var group_list;
var msg_list: Array[String]
var response_list_obj: ResponseList;

func _ready() -> void:
	# seta variaveis globais
	var relevantAreaController = get_tree().get_first_node_in_group("relevant_area_controller")
	response_list_obj = get_tree().get_first_node_in_group("response_list")

	# conecta o controller a lista para mostrar as respostas
	relevantAreaController.connect("get_current_area", Callable(self, "update_msg_list"))
	group_list = get_tree().get_nodes_in_group("relevant_area_group")
	

func update_msg_list(currentSelectArea: String) -> void:
	# adiciona frases na lista
	for group: RelevantArea in group_list:
		if group.area_group != currentSelectArea: continue
		if group.correct_answer_msg != "":
			msg_list.append(group.correct_answer_msg)
			pass
		if group.wrong_answer_msg != "":
			msg_list.append(group.wrong_answer_msg)
			pass

	# seguinte, eu achei que a melhor forma de lidar com essas listas e saber se esta com todos
	# os pontos checked seria fazendo isso na mao.
	# validateFirstCaseChecks(currentSelectArea)

	update_response_list()

# func validateFirstCaseChecks(currentSelectArea: String):
# 	Globals.relevant_area_list.

func update_response_list():
	for child in response_list_obj.get_children():
		if child is Label:
			child.text = format_msg_list()

func format_msg_list() -> String:
	var finalMsg = ""

	for msg in msg_list:
		finalMsg += (msg + "\n")
	return finalMsg
