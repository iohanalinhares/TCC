extends Node

var user_id = -1
var database = SQLite
var main_scene = null
var user_tips

@onready var teste = preload("res://levels/challenge_1.tscn")

# FUNÇÃO PARA ATUALIZAÇÃO DAS ESTRELAS CONFORME CONCLUSÃO DO USUÁRIO
func update_challenges(user_id: int) -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	var condition = "id = " + str(user_id)
	var data = database.select_rows("challanges", condition, ["id, level, challange01, challange02, challange03, challange04, challange05"])

	# CRIAÇÃO DO USUÁRIO NO BANCO DE DADOS, CASO ELE AINDA NÃO ESTEJA REGISTRADO
	if not data:
		var values = [user_id, 1, "not_completed", "not_completed", "not_completed", "not_completed", "not_completed"]
		database.query_with_bindings("INSERT INTO challanges VALUES (?, ?, ?, ?, ?, ?, ?)", values)
		data = database.select_rows("challanges", condition, ["id, level, challange01, challange02, challange03, challange04, challange05"])

	
	# CHAMA A FUNÇÃO DE ATUALIZAÇÃO DAS ESTRELAS NA CENA PRINCIPAL
	if main_scene:
		main_scene.update_challenges_ui(data[0])


func update_money_label(user_id: int) -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	var condition = "id = '" + str(user_id) + "'"
	
	# VERIFICA SE O USUÁRIO EXISTE NA TABELA TIPS, SE NÃO, INSERE UM NOVO REGISTRO
	var user_tips = database.select_rows("tips", condition, ["id"])
	if not user_tips:
		var values = [user_id, 1, 3, 3]
		database.query_with_bindings("INSERT INTO tips (id, ai, tip, cards) VALUES (?, ?, ?, ?)", values)

	if main_scene:
		main_scene.select_money()
		main_scene.validacao_de_compra()
