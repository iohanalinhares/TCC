extends Node

var user_id = -1

@onready var teste = preload("res://levels/challenge_1.tscn")

var database = SQLite
var main_scene = null

# Função para atualizar imagens
func update_challenges(user_id: int) -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	var condition = "id = " + str(user_id)
	var data = database.select_rows("challanges", condition, ["id, level, challange01, challange02, challange03, challange04, challange05"])

	# Se o usuário não existir, cria um novo registro
	if not data:
		var values = [user_id, 1, "not_completed", "not_completed", "not_completed", "not_completed", "not_completed"]
		database.query_with_bindings("INSERT INTO challanges VALUES (?, ?, ?, ?, ?, ?, ?)", values)
		data = database.select_rows("challanges", condition, ["id, level, challange01, challange02, challange03, challange04, challange05"])

		print("data[0]: ", data)
	# Atualiza as imagens na cena principal
	if main_scene:
		main_scene.update_challenges_ui(data[0])
