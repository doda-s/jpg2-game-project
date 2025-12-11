extends Node
var arrIndexed = [0, 2]
var arr = {}
var responseQuestion = []
var correctResponses = []
var responseScore: int = 0

func _ready() -> void:
	if not DialogHandler.dialog_ended_signal.is_connected(player_choice_map):
		DialogHandler.dialog_ended_signal.connect(player_choice_map)

	arr = Globals.obj_dialog
	responseQuestion = Globals.ResponseArr

	tratamentIndexed(arrIndexed)

	await get_tree().create_timer(3.0).timeout
	visibilityTrue($Panel)


func tratamentIndexed(arre: Array) -> void:
	var caso = ""
	var count = 0
	var lista_consequencias = []

	var perguntas = arr["DialogNodes"]

	if arr["Name"] == "caso-um":
		caso = "1"
	elif arr["Name"] == "caso-dois":
		caso = "2"

	for i in range(responseQuestion.size()):
		var pergunta_index = i
		var pergunta_num = i + 1
		var resposta_index = responseQuestion[i]
		var resposta_num = resposta_index + 1

		var pergunta = perguntas[pergunta_index]
		var opcoes = pergunta["Options"]
		var pergunta_texto = pergunta["Text"]
		var resposta_texto = opcoes[resposta_index]["Placeholder"]

		# Buscar resposta correta pelo array de consequencias
		var resposta_correta_num = buscar_resposta_correta(caso, pergunta_num)
		var resposta_correta_texto = opcoes[int(resposta_correta_num) - 1]["Placeholder"]

		var texto_conseq = buscar_consequencia(caso, pergunta_num, resposta_num)

		var texto_final = ""
		if str(resposta_num) == resposta_correta_num:
			# acertou
			texto_final = "Pergunta: " + pergunta_texto + "\nVocê respondeu: " + resposta_texto + "\nConsequência: " + texto_conseq
		else:
			# errou
			texto_final = "Pergunta: " + pergunta_texto + "\nVocê respondeu: " + resposta_texto + "\nConsequência: " + texto_conseq + "\nResposta correta: " + resposta_correta_texto

		lista_consequencias.append(texto_final)


	# Preenche os labels dentro do ScrollContainer/VBox
	$Panel/ScrollContainer/VBoxContainer.add_theme_constant_override("separation", 25)
	for child in $Panel/ScrollContainer/VBoxContainer.get_children():
		var texto = lista_consequencias[count]
		child.text = texto
		if texto.contains("Resposta correta: "):
			child.add_theme_color_override("font_color", Color(1, 0, 0)) # vermelho
		else:
			child.remove_theme_color_override("font_color")
		count += 1

func buscar_consequencia(caso: String, pergunta: int, resposta: int) -> String:
	for item in consequencia:
		if item["Caso"] == caso and item["Pergunta"] == str(pergunta) and item["Respostas"] == str(resposta):
			return item["consequencia"]
	return "Sem consequência cadastrada."


func buscar_resposta_correta(caso: String, pergunta: int) -> String:
	for item in consequencia:
		if item["Caso"] == caso and item["Pergunta"] == str(pergunta) and item["correct"] == "true":
			return item["Respostas"]
	return "-1"


func visibilityTrue(node):
	node.visible = true
	node.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 1.0, 0.5).as_relative()


func _on_button_pressed():
	SceneSwitcher.switch_scene("res://scenes/worlds/boss_office_room.tscn")


func player_choice_map(arr_choice_map):
	responseQuestion = arr_choice_map
	
var consequencia = [
	# CASO 1
	# Pergunta 1
	{"Caso": "1", "Pergunta": "1", "Respostas": "1", "correct": "false", "consequencia": "O juiz considerou a resposta incorreta. A defesa perdeu credibilidade."},
	{"Caso": "1", "Pergunta": "1", "Respostas": "2", "correct": "false", "consequencia": "O juiz achou a explicação inconsistente. Defesa enfraquecida."},
	{"Caso": "1", "Pergunta": "1", "Respostas": "3", "correct": "true", "consequencia": "O juiz reconheceu a argumentação correta e valorizou a defesa. A defesa ganhou credibilidade."},
	{"Caso": "1", "Pergunta": "1", "Respostas": "4", "correct": "false", "consequencia": "O juiz rejeitou a alegação como falsa. Defesa prejudicada."},

	# Pergunta 2
	{"Caso": "1", "Pergunta": "2", "Respostas": "1", "correct": "false", "consequencia": "O juiz ironizou o argumento, chamando de “cronologia seletiva”."},
	{"Caso": "1", "Pergunta": "2", "Respostas": "2", "correct": "false", "consequencia": "O juiz corrigiu dizendo que a lei estava vigente desde a publicação."},
	{"Caso": "1", "Pergunta": "2", "Respostas": "3", "correct": "true", "consequencia": "O juiz concordou com a interpretação correta."},
	{"Caso": "1", "Pergunta": "2", "Respostas": "4", "correct": "false", "consequencia": "O juiz lembrou que leis ambientais não retroagem."},

	# Pergunta 3
	{"Caso": "1", "Pergunta": "3", "Respostas": "1", "correct": "false", "consequencia": "O juiz afirmou que isso não tem apoio jurídico."},
	{"Caso": "1", "Pergunta": "3", "Respostas": "2", "correct": "true", "consequencia": "O juiz reconheceu o acerto técnico."},
	{"Caso": "1", "Pergunta": "3", "Respostas": "3", "correct": "false", "consequencia": "O juiz rebateu de imediato: “Ambiental não funciona assim”."},
	{"Caso": "1", "Pergunta": "3", "Respostas": "4", "correct": "false", "consequencia": "O juiz rejeitou porque contrariava a Constituição."},

	# Pergunta 4
	{"Caso": "1", "Pergunta": "4", "Respostas": "1", "correct": "false", "consequencia": "O juiz classificou como absurdo jurídico."},
	{"Caso": "1", "Pergunta": "4", "Respostas": "2", "correct": "true", "consequencia": "O juiz concordou"},
	{"Caso": "1", "Pergunta": "4", "Respostas": "3", "correct": "false", "consequencia": "O juiz explicou que isso não existe no direito."},
	{"Caso": "1", "Pergunta": "4", "Respostas": "4", "correct": "false", "consequencia": "O juiz rejeitou rapidamente, criticando a lógica."},

	# Pergunta 5
	{"Caso": "1", "Pergunta": "5", "Respostas": "1", "correct": "false", "consequencia": "O juiz rejeitou imediatamente."},
	{"Caso": "1", "Pergunta": "5", "Respostas": "2", "correct": "false", "consequencia": "O juiz afirmou que planejamento não gera direito."},
	{"Caso": "1", "Pergunta": "5", "Respostas": "3", "correct": "true", "consequencia": "O juiz concordou."},
	{"Caso": "1", "Pergunta": "5", "Respostas": "4", "correct": "false", "consequencia": "O juiz disse que isso é incompatível com a Constituição."},

	# CASO 2
	# Pergunta 1
	{"Caso": "2", "Pergunta": "1", "Respostas": "1", "correct": "false", "consequencia": "O juiz mostra estranheza com a simplicidade da resposta."},
	{"Caso": "2", "Pergunta": "1", "Respostas": "2", "correct": "true", "consequencia": "O juiz reconhece que o advogado entendeu corretamente o cerne constitucional do conflito."},
	{"Caso": "2", "Pergunta": "1", "Respostas": "3", "correct": "false", "consequencia": "O juiz critica a ideia de ignorar direitos fundamentais."},
	{"Caso": "2", "Pergunta": "1", "Respostas": "4", "correct": "false", "consequencia": "O juiz critica a noção de favorecimento automático."},

	# Pergunta 2
	{"Caso": "2", "Pergunta": "2", "Respostas": "1", "correct": "true", "consequencia": "O juiz concorda que é fundamentado. Defesa se fortalece."},
	{"Caso": "2", "Pergunta": "2", "Respostas": "2", "correct": "false", "consequencia": "O juiz afirma que utilidade pública não elimina direitos."},
	{"Caso": "2", "Pergunta": "2", "Respostas": "3", "correct": "false", "consequencia": "O juiz percebe citação equivocada."},
	{"Caso": "2", "Pergunta": "2", "Respostas": "4", "correct": "false", "consequencia": "O juiz considera a resposta inadequada."},

	# Pergunta 3
	{"Caso": "2", "Pergunta": "3", "Respostas": "1", "correct": "false", "consequencia": "O juiz corrige dizendo que prisão não define culpabilidade."},
	{"Caso": "2", "Pergunta": "3", "Respostas": "2", "correct": "true", "consequencia": "O juiz confirma a interpretação correta."},
	{"Caso": "2", "Pergunta": "3", "Respostas": "3", "correct": "false", "consequencia": "O juiz afirma que isso inverte totalmente o princípio."},
	{"Caso": "2", "Pergunta": "3", "Respostas": "4", "correct": "false", "consequencia": "O juiz aponta que o argumento é fantasioso e sem base legal."},
	
	# Pergunta 4
	{"Caso": "2", "Pergunta": "4", "Respostas": "1", "correct": "false", "consequencia": "O juiz critica a falta de análise dos impactos."},
	{"Caso": "2", "Pergunta": "4", "Respostas": "2", "correct": "false", "consequencia": "O juiz explica que proporcionalidade não admite decisões automáticas."},
	{"Caso": "2", "Pergunta": "4", "Respostas": "3", "correct": "false", "consequencia": "O juiz afirma que nenhum direito tem prioridade automática."},
	{"Caso": "2", "Pergunta": "4", "Respostas": "4", "correct": "true", "consequencia": "O juiz aprova a abordagem técnica."},

	# Pergunta 5
	{"Caso": "2", "Pergunta": "5", "Respostas": "1", "correct": "true", "consequencia": "O juiz considera a resposta equilibrada e adequada. Defesa ganha força."},
	{"Caso": "2", "Pergunta": "5", "Respostas": "2", "correct": "false", "consequencia": "O juiz reprova a medida extrema e autoritária. A defesa perde credibilidade."},
	{"Caso": "2", "Pergunta": "5", "Respostas": "3", "correct": "false", "consequencia": "O juiz critica a falta de ponderação. Defesa demonstra desconhecimento."},
	{"Caso": "2", "Pergunta": "5", "Respostas": "4", "correct": "false", "consequencia": "O juiz alerta que isso violaria a liberdade de expressão. A defesa perde pontos."},
]
