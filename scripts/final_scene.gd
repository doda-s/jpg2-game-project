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
var arr = {}
var responseQuestion = []
var responseScore: int = 0

func _ready() -> void:
	#arr = Globals.response_final_list
	if not DialogHandler.dialog_ended_signal.is_connected(player_choice_map):
		DialogHandler.dialog_ended_signal.connect(player_choice_map)
		arr = Globals.obj_dialog
		print("O arr é: ", arr)
		responseQuestion = Globals.ResponseArr
		print("Respostas do array: ", responseQuestion)
	
	tratamentIndexed(arrIndexed)
	await get_tree().create_timer(2.0).timeout
	visibilityTrue($Panel)

func tratamentIndexed(arre: Array) -> void:
	var caso = ""
	var count = 0
	var lista_consequencias = []

	# Arr = seu dialogo atual
	var perguntas = arr["DialogNodes"]

	print("o valor é: ", arr["Name"])

	if arr["Name"] == "caso-um":
		caso = "1"
		print("Funcionou caso 1!")

	if arr["Name"] == "caso-dois":
		caso = "2"
		print("Funcionou caso 2!")

	# Loop das respostas do jogador
	for i in range(responseQuestion.size()):
		var pergunta_index = i                # índice da pergunta no array
		var pergunta_num   = i + 1            # número 1,2,3...
		var resposta_index = responseQuestion[i]
		var resposta_num   = resposta_index + 1

		# Pega pergunta atual
		var pergunta = perguntas[pergunta_index]
		var opcoes = pergunta["Options"]

		# Texto da resposta do jogador
		var pergunta_texto = perguntas[pergunta_index]['Text']
		
		var resposta_texto = opcoes[resposta_index]["Placeholder"]

		# Texto da resposta correta (sempre a primeira)
		var resposta_correta = opcoes[0]["Placeholder"]

		# Monta o texto a ser mostrado
		var texto_final = ""

		# Acertou?
		if resposta_index == 0:
			var texto_conseq = buscar_consequencia(caso, pergunta_num, resposta_num)
			texto_final = "Pergunta: " + pergunta_texto + "Você respondeu: " + resposta_texto + "\n" + "Consequência: " + texto_conseq
		else:
			texto_final = "Pergunta: " + pergunta_texto + "Você respondeu: " + resposta_texto + "\n" + "Resposta correta: " + resposta_correta

		lista_consequencias.append(texto_final)

		print("CASO:", caso)
		print("PERGUNTA:", pergunta_num)
		print("RESPOSTA:", resposta_num)
		print("TEXTO FINAL:", texto_final)
		print("Pergunta FINAL:", pergunta_texto)
		

	# Preenche os labels dentro do seu ScrollContainer/VBox
	for child in $Panel/ScrollContainer/VBoxContainer.get_children():
		child.text = lista_consequencias[count]
		count += 1


func buscar_consequencia(caso: String, pergunta: int, resposta: int):
	for item in consequencia:
		if item["Caso"] == caso \
		and item["Pergunta"] == str(pergunta) \
		and item["Respostas"] == str(resposta):
			return item["consequencia"]
	
	return "Sem consequência cadastrada."

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
	responseQuestion = arr_choice_map
	print("FIlho da puta", arr_choice_map)
	
	
var consequencia = [
	# CASO 1
	# Pergunta 1
	{"Caso":"1","Pergunta":"1","Respostas":"1","consequencia":"O juiz reconheceu a argumentação correta e valorizou a defesa. A defesa ganhou credibilidade."},
	{"Caso":"1","Pergunta":"1","Respostas":"2","consequencia":"O juiz considerou a resposta incorreta. A defesa perdeu credibilidade."},
	{"Caso":"1","Pergunta":"1","Respostas":"3","consequencia":"O juiz achou a explicação inconsistente. Defesa enfraquecida."},
	{"Caso":"1","Pergunta":"1","Respostas":"4","consequencia":"O juiz rejeitou a alegação como falsa. Defesa prejudicada."},

	# Pergunta 2
	{"Caso":"1","Pergunta":"2","Respostas":"1","consequencia":"O juiz concordou com a interpretação correta. Defesa tecnicamente sólida."},
	{"Caso":"1","Pergunta":"2","Respostas":"2","consequencia":"O juiz ironizou o argumento, chamando de “cronologia seletiva”. Defesa enfraquecida."},
	{"Caso":"1","Pergunta":"2","Respostas":"3","consequencia":"O juiz corrigiu dizendo que a lei estava vigente desde a publicação. Credibilidade reduzida."},
	{"Caso":"1","Pergunta":"2","Respostas":"4","consequencia":"O juiz lembrou que leis ambientais não retroagem. Má impressão."},

	# Pergunta 3
	{"Caso":"1","Pergunta":"3","Respostas":"1","consequencia":"O juiz reconheceu o acerto técnico. Defesa preservada."},
	{"Caso":"1","Pergunta":"3","Respostas":"2","consequencia":"O juiz afirmou que isso não tem apoio jurídico. Argumento descartado."},
	{"Caso":"1","Pergunta":"3","Respostas":"3","consequencia":"O juiz rebateu de imediato: “Ambiental não funciona assim”. Defesa enfraquecida."},
	{"Caso":"1","Pergunta":"3","Respostas":"4","consequencia":"O juiz rejeitou porque contrariava a Constituição. Péssimo para a defesa."},

	# Pergunta 4
	{"Caso":"1","Pergunta":"4","Respostas":"1","consequencia":"O juiz concordou. Defesa correta, obra continua irregular."},
	{"Caso":"1","Pergunta":"4","Respostas":"2","consequencia":"O juiz classificou como absurdo jurídico. Defesa abalada."},
	{"Caso":"1","Pergunta":"4","Respostas":"3","consequencia":"O juiz explicou que isso não existe no direito. Defesa perdeu ponto."},
	{"Caso":"1","Pergunta":"4","Respostas":"4","consequencia":"O juiz rejeitou rapidamente, criticando a lógica."},

	# Pergunta 5
	{"Caso":"1","Pergunta":"5","Respostas":"1","consequencia":"O juiz concordou. Defesa técnica, obra segue embargada."},
	{"Caso":"1","Pergunta":"5","Respostas":"2","consequencia":"O juiz rejeitou imediatamente. Situação piorou."},
	{"Caso":"1","Pergunta":"5","Respostas":"3","consequencia":"O juiz afirmou que planejamento não gera direito. Defesa perdeu credibilidade."},
	{"Caso":"1","Pergunta":"5","Respostas":"4","consequencia":"O juiz disse que isso é incompatível com a Constituição. Grande prejuízo à defesa."},

	# CASO 2
	# Pergunta 1
	{"Caso":"2","Pergunta":"1","Respostas":"1","consequencia":"O juiz reconhece que o advogado entendeu corretamente o cerne constitucional do conflito. A defesa ganha credibilidade técnica."},
	{"Caso":"2","Pergunta":"1","Respostas":"2","consequencia":"O juiz mostra estranheza com a simplicidade da resposta; a defesa perde força."},
	{"Caso":"2","Pergunta":"1","Respostas":"3","consequencia":"O juiz critica a ideia de ignorar direitos fundamentais. Defesa desfavorecida."},
	{"Caso":"2","Pergunta":"1","Respostas":"4","consequencia":"O juiz critica a noção de favorecimento automático. Defesa perde credibilidade."},

	# Pergunta 2
	{"Caso":"2","Pergunta":"2","Respostas":"1","consequencia":"O juiz concorda que é fundamentado. Defesa se fortalece."},
	{"Caso":"2","Pergunta":"2","Respostas":"2","consequencia":"O juiz afirma que utilidade pública não elimina direitos. Defesa perde credibilidade."},
	{"Caso":"2","Pergunta":"2","Respostas":"3","consequencia":"O juiz percebe citação equivocada. Defesa enfraquece."},
	{"Caso":"2","Pergunta":"2","Respostas":"4","consequencia":"O juiz considera a resposta inadequada. Defesa parece despreparada."},

	# Pergunta 3
	{"Caso":"2","Pergunta":"3","Respostas":"1","consequencia":"O juiz confirma a interpretação correta. A defesa demonstra domínio técnico."},
	{"Caso":"2","Pergunta":"3","Respostas":"2","consequencia":"O juiz corrige dizendo que prisão não define culpabilidade. A defesa perde autoridade."},
	{"Caso":"2","Pergunta":"3","Respostas":"3","consequencia":"O juiz afirma que isso inverte totalmente o princípio. Péssima impressão."},
	{"Caso":"2","Pergunta":"3","Respostas":"4","consequencia":"O juiz aponta que o argumento é fantasioso e sem base legal. Defesa sofre desgaste."},

	# Pergunta 4
	{"Caso":"2","Pergunta":"4","Respostas":"1","consequencia":"O juiz aprova a abordagem técnica. A defesa avança com clareza jurídica."},
	{"Caso":"2","Pergunta":"4","Respostas":"2","consequencia":"O juiz critica a falta de análise dos impactos. Defesa enfraquece."},
	{"Caso":"2","Pergunta":"4","Respostas":"3","consequencia":"O juiz explica que proporcionalidade não admite decisões automáticas. A defesa é mal vista."},
	{"Caso":"2","Pergunta":"4","Respostas":"4","consequencia":"O juiz afirma que nenhum direito tem prioridade automática. A defesa perde espaço."},

	# Pergunta 5
	{"Caso":"2","Pergunta":"5","Respostas":"1","consequencia":"O juiz considera a resposta equilibrada e adequada. Defesa ganha força."},
	{"Caso":"2","Pergunta":"5","Respostas":"2","consequencia":"O juiz reprova a medida extrema e autoritária. A defesa perde credibilidade."},
	{"Caso":"2","Pergunta":"5","Respostas":"3","consequencia":"O juiz critica a falta de ponderação. Defesa demonstra desconhecimento."},
	{"Caso":"2","Pergunta":"5","Respostas":"4","consequencia":"O juiz alerta que isso violaria a liberdade de expressão. A defesa perde pontos."},
]
