extends Node2D

# Dicionário com os dados do personagem
var personagem = {
	"nome": "",
	"idade": 0,
	"casos_resolvidos": [],
	"casos_ganhos": 0,
	"casos_perdidos": 0,
	"conquistas": []
}

var save_path = "res://savegame.json"

# Criar pasta 'saves' se não existir
func _ready():
	var dir = DirAccess.open("user://")
	if not dir.dir_exists("saves"):
		dir.make_dir("saves")
	# tenta carregar automaticamente
	carregar_personagem()
	#var PlayerScene = preload("res://player.tscn")
	#var player = PlayerScene.instantiate()
	#player.setup(data)
	

# Salvar personagem
func salvar_personagem():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(personagem))
		file.close()
		print("✅ Personagem salvo:", personagem)
	#get_tree().change_scene_to_file("res://movimentacao.tscn")
	#_ready()

# Carregar personagem
func carregar_personagem():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var conteudo = file.get_as_text()
		var data = JSON.parse_string(conteudo)
		if typeof(data) == TYPE_DICTIONARY:
			personagem = data
			print("✅ Personagem carregado:", personagem)
		file.close()
	else:
		print("⚠ Nenhum save encontrado, criando novo...")

func adicionar_casos(caso: int):
	if caso in personagem["casos_resolvidos"]:
		print("⚠ Caso já resolvido:", caso)
		return
		
	personagem["casos_resolvidos"].append(caso)
	salvar_personagem()
	print("✅ Caso adicionado:", caso)
	
func adicionar_conq(conq: String):
	if conq in personagem["conquistas"]:
		print("Conquista ja pega:", conq)
		return

	personagem["conquistas"].append(conq)
	salvar_personagem()
	print("✅ Conquista adicionado:", conq)
	

# Botão de criar novo personagem
func _on_button_pressed1() -> void:
	personagem["nome"] = "Jogador1"
	personagem["idade"] = 2
	personagem["casos_resolvidos"] = []
	personagem["conquistas"] = []
	salvar_personagem()

# Botão de carregar personagem
func _on_button_2_pressed2() -> void:
	carregar_personagem()


func _adicionar_fase_1() -> void:
	adicionar_casos(1)


func _adicionar_conq_1() -> void:
	adicionar_conq("Completar fase 1")
