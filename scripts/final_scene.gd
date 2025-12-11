extends Node
var arrIndexed = [0, 2]
var arr = {}
var responseQuestion = []
var correctResponses = []
var responseScore: int = 0
var returnScene = ""

func _ready() -> void:
	if not DialogHandler.dialog_ended_signal.is_connected(player_choice_map):
		DialogHandler.dialog_ended_signal.connect(player_choice_map)

	arr = Globals.obj_dialog

	responseQuestion = Globals.ResponseArr

	tratamentIndexed()

	await get_tree().create_timer(3.0).timeout
	visibilityTrue($Panel)


func tratamentIndexed() -> void:
	var caso = ""
	var count = 0
	var lista_consequencias = []

	var perguntas = arr["DialogNodes"]

	if arr["Name"] == "perguntas-vasconcelos-1":
		caso = "1"
		returnScene = "res://scenes/worlds/boss_office_room/boss_office_room_D1T.tscn"
		
	elif arr["Name"] == "cena3-caso-miguel":
		caso = "2"
		returnScene = "res://scenes/worlds/boss_office_room/boss_office_room_D2T.tscn"

	for i in range(responseQuestion.size()):
		var pergunta_index = i
		var pergunta_num = i + 1
		var resposta_index = responseQuestion[i]
		var resposta_num = resposta_index + 1
		print("Pergunta_index: ", pergunta_index)
		print("pergunta_num: ", pergunta_num)
		print("resposta_index: ", resposta_index)
		print("resposta_num: ", resposta_num)
		

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
		print("RESPOSTA: ", texto)
		child.text = texto
		if texto.contains("Resposta correta: "):
			child.add_theme_color_override("font_color", Color(1, 0, 0)) # vermelho
		else:
			child.remove_theme_color_override("font_color")

		count += 1

func buscar_consequencia(caso: String, pergunta: int, resposta: int) -> String:
	print("oi:", caso, " pergunta: ", pergunta, " resposta ", resposta)
	for item in consequencia:
		if item["Caso"] == caso and item["Pergunta"] == str(pergunta) and item["Respostas"] == str(resposta):
			print("OI: ", caso, " pergunta: ", pergunta, " resposta", resposta)
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
	SceneSwitcher.switch_scene(returnScene)


func player_choice_map(arr_choice_map):
	responseQuestion = arr_choice_map
	
var consequencia = [
	# CASO 1
	# Pergunta 1
	{"Caso": "1", "Pergunta": "1", "Respostas": "1", "correct": "false", "consequencia": "Então, na prática, você está dizendo que um ato da Prefeitura congela o mundo jurídico e garante à Joana um passe vitalício.
Se essa for a tese, o juiz vê na hora que você está confundindo autorização administrativa com direito absoluto. Segurança jurídica não é isso."},
	{"Caso": "1", "Pergunta": "1", "Respostas": "2", "correct": "false", "consequencia": "A lógica aí é: ‘se não havia lei na época, ela nunca poderá tocar na obra’.
O problema é que o impacto na lagoa não ficou preso em 2018: ele continua hoje.
Lei nova pode, sim, exigir que aquilo que ainda está em andamento se ajuste."},
	{"Caso": "1", "Pergunta": "1", "Respostas": "3", "correct": "true", "consequencia": "Essa linha anda melhor.
Você não finge que o alvará municipal não existiu, mas também não transforma ele em escudo mágico.
Reconhece que a obra, a partir de 2023, passa a ter que conversar com as regras da lei estadual ambiental, sobretudo por mexer com a lagoa."},
	{"Caso": "1", "Pergunta": "1", "Respostas": "4", "correct": "false", "consequencia": "Citar ‘segurança jurídica’ pra afastar qualquer atuação fiscalizatória é um atalho perigoso.
Em matéria ambiental, a atuação do Estado continua depois do carimbo.
Se você passa a sensação de que, uma vez emitido o alvará, ninguém mais pode tocar no assunto, o juiz estranha – com razão."},

	# Pergunta 2
	{"Caso": "1", "Pergunta": "2", "Respostas": "1", "correct": "false", "consequencia": "Você está transformando a lei num instrumento pra revisar o passado.
Em regra, a preocupação aqui não é ‘corrigir o que já morreu’, mas enquadrar o que ainda está produzindo efeito.
A obra da Joana está acontecendo agora, não em 2018."},
	{"Caso": "1", "Pergunta": "2", "Respostas": "2", "correct": "false", "consequencia": "Essa leitura conversa bem com o que o juiz costuma enxergar.
A lei estadual não apaga automaticamente tudo o que foi feito antes, mas passa a controlar os efeitos futuros – e a obra da Joana ainda está mexendo na lagoa.
É aí que o caso aperta pra ela."},
	{"Caso": "1", "Pergunta": "2", "Respostas": "3", "correct": "true", "consequencia": "Se só pegasse processos ‘em análise’, bastaria correr pra tirar o primeiro alvará municipal e nunca mais olhar para a legislação.
O Direito Ambiental tenta justamente evitar essa corrida do ouro."},
	{"Caso": "1", "Pergunta": "2", "Respostas": "4", "correct": "false", "consequencia": "Dizer que a lei vale só pra novos pedidos é escolher ignorar o estrago que uma obra em andamento pode estar fazendo agora.
A lagoa não sabe se o protocolo é de 2018 ou de 2024 – ela sente o impacto."},

	# Pergunta 3
	{"Caso": "1", "Pergunta": "3", "Respostas": "1", "correct": "false", "consequencia": "Você acabou de batizar ‘planejamento + alvará’ como fórmula do direito adquirido eterno.
Se essa conta fechasse, seria só planejar rápido qualquer intervenção sensível e blindar tudo para sempre.
Não é por aí que o Direito Ambiental costuma caminhar."},
	{"Caso": "1", "Pergunta": "3", "Respostas": "2", "correct": "true", "consequencia": "Aqui a argumentação respira melhor.
Você não apaga o que foi feito antes, mas lembra que, a partir do momento em que o ordenamento passa a enxergar aquele cenário como lesivo à lagoa, não dá pra congelar o dano em nome de ‘direito adquirido’."},
	{"Caso": "1", "Pergunta": "3", "Respostas": "3", "correct": "false", "consequencia": "Isso é quase dizer que a autorização municipal de 2018 criou um ‘mundo paralelo’ em que a lei estadual não entra.
O problema é que o impacto não fica dentro da prefeitura: ele acontece na lagoa, e é ela que o legislador estadual está protegendo."},
	{"Caso": "1", "Pergunta": "3", "Respostas": "4", "correct": "false", "consequencia": "Propriedade é um direito importante, mas não é uma ilha isolada.
Hoje se fala em função socioambiental.
Se a sua tese soa como ‘o terreno manda mais que o meio ambiente’, algo precisa ser corrigido."},

	# Pergunta 4
	{"Caso": "1", "Pergunta": "4", "Respostas": "1", "correct": "false", "consequencia": "Você continua colocando o alvará municipal como eixo de tudo e tratando a lei estadual como figurante.
Quando o cenário é de proteção ambiental mais rígida, essa inversão de peso não soa bem aos ouvidos do juiz."},
	{"Caso": "1", "Pergunta": "4", "Respostas": "2", "correct": "true", "consequencia": "Aqui você entrega uma conclusão honesta.
A obra não some do mapa, o alvará também não, mas o espaço de atuação deles diminui quando a lei estadual passa a proibir exatamente o tipo de intervenção que a Joana está fazendo na lagoa.
A partir daí, insistir na obra é caminhar em terreno irregular."},
	{"Caso": "1", "Pergunta": "4", "Respostas": "3", "correct": "false", "consequencia": "Falar em ‘equilíbrio’ aqui é uma forma elegante de não encarar o ponto central:
se você sempre escolher o caminho mais favorável ao particular, mesmo diante de normas ambientais mais rígidas, a proteção da lagoa vira um detalhe."},
	{"Caso": "1", "Pergunta": "4", "Respostas": "4", "correct": "false", "consequencia": "Essa ideia de que basta ter obtido uma autorização em 2018 para ficar imune a qualquer mudança posterior é exatamente o tipo de discurso que o Direito Ambiental vem tentando superar.
Se o parecer ficar só nisso, a decisão dificilmente seguirá por esse caminho."},

	## Pergunta 5
	#{"Caso": "1", "Pergunta": "5", "Respostas": "1", "correct": "false", "consequencia": "O juiz rejeitou imediatamente."},
	#{"Caso": "1", "Pergunta": "5", "Respostas": "2", "correct": "false", "consequencia": "O juiz afirmou que planejamento não gera direito."},
	#{"Caso": "1", "Pergunta": "5", "Respostas": "3", "correct": "true", "consequencia": "O juiz concordou."},
	#{"Caso": "1", "Pergunta": "5", "Respostas": "4", "correct": "false", "consequencia": "O juiz disse que isso é incompatível com a Constituição."},

	# CASO 2
	# Pergunta 1
	{"Caso": "2", "Pergunta": "1", "Respostas": "1", "correct": "false", "consequencia": "Discutir propriedade do blog aqui é gastar munição no alvo errado.
O ponto não é se o site é dele, é o que ele fez com o espaço em relação à imagem do Miguel."},
	{"Caso": "2", "Pergunta": "1", "Respostas": "2", "correct": "true", "consequencia": "É aqui que a coisa esquenta.
De um lado, um blog que diz estar informando sobre operação de corrupção; de outro, um ex-deputado que se vê retratado como figura central do escândalo.
É nesse choque entre liberdade de informar e proteção da honra/imagem que o juiz vai trabalhar."},
	{"Caso": "2", "Pergunta": "1", "Respostas": "3", "correct": "false", "consequencia": "Ficar só na intimidade é reduzir o problema demais.
A manchete coloca o Miguel no meio de uma ‘operação milionária de corrupção’.
Isso toca na reputação política e pessoal, muito além de vida íntima."},
	{"Caso": "2", "Pergunta": "1", "Respostas": "4", "correct": "false", "consequencia": "Vida pública não é sinônimo de autorização pra qualquer tipo de exposição.
O fato de ele ser ex-deputado aumenta o interesse público, não diminui direitos fundamentais."},

	# Pergunta 2
	{"Caso": "2", "Pergunta": "2", "Respostas": "1", "correct": "true", "consequencia": "Essa abordagem é mais fina.
Você não manda calar a imprensa, mas lembra que existe diferença entre dizer ‘ex-deputado é investigado em operação de corrupção’ e apresentar a manchete como se a participação dele já estivesse definida.
A presunção de inocência entra bem aí."},
	{"Caso": "2", "Pergunta": "2", "Respostas": "2", "correct": "false", "consequencia": "Então, bastou a operação começar e já está liberado tratar o investigado como se estivesse com a culpa sacramentada?
A presunção de inocência justamente tenta conter essa pressa em transformar investigação em veredito público."},
	{"Caso": "2", "Pergunta": "2", "Respostas": "3", "correct": "false", "consequencia": "Se fosse só processual, o sujeito seria inocente perante o juiz e condenado diariamente nas manchetes.
O sistema não lida bem com essa esquizofrenia.
A forma de noticiar também sofre influência desse princípio."},
	{"Caso": "2", "Pergunta": "2", "Respostas": "4", "correct": "false", "consequencia": "Ser ex-deputado não cancela o artigo que fala da presunção de inocência.
Se essa for a linha, o juiz vai ver mais preconceito com político do que raciocínio jurídico."},

	# Pergunta 3
	{"Caso": "2", "Pergunta": "3", "Respostas": "1", "correct": "false", "consequencia": "Invocar ‘interesse público’ e achar que isso fecha a conta é simplificar demais.
O fato de a operação ser relevante não significa que o jornalista pode, sem nenhum cuidado, jogar a foto do sujeito algemado, em destaque, como se já estivesse moralmente condenado."},
	{"Caso": "2", "Pergunta": "3", "Respostas": "2", "correct": "true", "consequencia": "Aqui você enxerga o quadro inteiro.
Não é só a operação:
– manchete de escândalo,
– Miguel associado à ‘operação milionária de corrupção’,
– e a foto dele algemado, em posição de total fragilidade.
Esse conjunto passa pro leitor a sensação de que a culpa dele já está decidida.
É exatamente isso que o advogado precisa mostrar ao juiz."},
	{"Caso": "2", "Pergunta": "3", "Respostas": "3", "correct": "false", "consequencia": "Tratar a imagem como detalhe é esquecer como as pessoas consomem notícia hoje.
Muita gente forma opinião só com manchete + foto.
Quando essa foto mostra o ex-deputado algemado no meio da operação, fingir que isso não pesa na honra dele é, no mínimo, inocente."},
	{"Caso": "2", "Pergunta": "3", "Respostas": "4", "correct": "false", "consequencia": "Dizer que qualquer limite ao uso de imagens de operação policial ‘fere a imprensa’ é empurrar a discussão pro extremo.
Liberdade de imprensa existe, mas não é licença pra expor alguém algemado, num cenário de escândalo, de qualquer jeito, sem avaliar o impacto que isso tem na dignidade e na reputação da pessoa."},
	
	# Pergunta 4
	{"Caso": "2", "Pergunta": "4", "Respostas": "1", "correct": "false", "consequencia": "‘Dever de usar linguagem dura’ é um conceito que não costuma aparecer nos códigos.
Informar com firmeza é uma coisa; transformar o sujeito em protagonista de um escândalo ainda em apuração é outra história."},
	{"Caso": "2", "Pergunta": "4", "Respostas": "2", "correct": "false", "consequencia": "Chamar isso de ‘só mau gosto’ é ignorar o peso que uma manchete dessas tem na vida real.
Pra quem vive de reputação – seja na política, seja fora dela – ser associado a uma ‘operação milionária de corrupção’ não é detalhe estético."},
	{"Caso": "2", "Pergunta": "4", "Respostas": "3", "correct": "false", "consequencia": "Se toda vez que alguém é ex-agente político tiver que engolir qualquer manchete sem reagir, a mensagem é simples:
‘vire político e perca a proteção jurídica’.
Não é essa a lógica do sistema."},
	{"Caso": "2", "Pergunta": "4", "Respostas": "4", "correct": "true", "consequencia": "Essa conclusão entrega o que o juiz precisa ler.
Você reconhece o lado da imprensa – a operação é relevante – mas mostra que o blog cruzou a linha quando tratou o Miguel como se a participação dele no esquema já estivesse definida.
É aí que entram direito de resposta e a conversa sobre indenização."},

	## Pergunta 5
	#{"Caso": "2", "Pergunta": "5", "Respostas": "1", "correct": "true", "consequencia": "O juiz considera a resposta equilibrada e adequada. Defesa ganha força."},
	#{"Caso": "2", "Pergunta": "5", "Respostas": "2", "correct": "false", "consequencia": "O juiz reprova a medida extrema e autoritária. A defesa perde credibilidade."},
	#{"Caso": "2", "Pergunta": "5", "Respostas": "3", "correct": "false", "consequencia": "O juiz critica a falta de ponderação. Defesa demonstra desconhecimento."},
	#{"Caso": "2", "Pergunta": "5", "Respostas": "4", "correct": "false", "consequencia": "O juiz alerta que isso violaria a liberdade de expressão. A defesa perde pontos."},
]
