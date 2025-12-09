extends Node

var teste = [
	{
		"question": "meu pinto tem 33 centimetros",
		"nota": 2
	}, 
	{
		"question": "meu pinto tem 39 centimetros",
		"nota": 4
	},
	{
		"question": "meu pinto tem 21 centimetros",
		"nota": 3
	}
]



var arrIndexed = [0, 2]
var arr = []
var responseQuestion = []
var responseScore: int = 0

func _ready() -> void:
	#arr = Globals.response_final_list
	if not DialogHandler.dialog_ended_signal.is_connected(player_choice_map):
		DialogHandler.dialog_ended_signal.connect(player_choice_map)
		print("Respostas do array: ", Globals.ResponseArr)

	tratamentIndexed(arrIndexed)
	#tratament(teste)
	print("ResponseQuestion: ", responseQuestion)
	await get_tree().create_timer(2.0).timeout
	visibilityTrue($Panel)

func tratament(arr: Array) -> void:
	for element in arr:
		responseQuestion.append(element.question)
		responseScore += element.nota
		print(">>> TESTE: ", responseScore, " ", element.question)
		pass

func tratamentIndexed(arr: Array) -> void:
	var count = 0
	for child in $Panel/VBoxContainer.get_children():
		var response = teste[arr[count]]
		child.text = response['question']
		count += 1
		pass

func visibilityTrue(node):
	node.visible = true
	node.modulate.a = 0.0  # começa transparente

	# anima para opaco em 0.5s
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 1.0, 0.5).as_relative()

var next_scene = preload("res://scenes/demos/side_scrolling_moviment.tscn")

func _on_button_pressed():
	Globals.pop()
	
func player_choice_map(arr_choice_map):
	arr = arr_choice_map
	print_debug(arr_choice_map)
