extends Node2D

var database = SQLite
var translator
#var new_texture = load("res://assets/icons/star-completed.png")

var filled_texture = preload("res://assets/icons/star-completed.png")
var empty_texture = preload("res://assets/icons/star.png")

func _ready():
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	var user_id = Global.user_id
		
	var condition = "id = '" + str(user_id) + "'"
	var query_result = database.select_rows("users", condition, ["money, language"])

	var money = $"Money"
	if query_result:
		money.text = str(query_result[0].money)
	else:
		money.text = "0"
		
	# VERIFICAÇÃO DO USUÁRIO NA TABLE CHALLANGES
	var insert_table = """
		INSERT INTO challanges (id, level, challange01, challange02, challange03, challange04, challange05)
		VALUES(?, ?, ?, ?, ?, ?, ?)
	"""
	
	var user_challanges = database.select_rows("challanges", condition, ["id, level, challange01, challange02, challange03, challange04, challange05"])
	
	# VERIFICA SE O USUÁRIO EXISTE NA TABLE OU SE É PRECISO CRIAR UM ITEM DELE
	if !user_challanges:
		var values = [user_id, 1, "not_completed", "not_completed", "not_completed", "not_completed", "not_completed"]
		database.query_with_bindings(insert_table, values)
		user_challanges = database.select_rows("challanges", condition, ["id, level, challange01, challange02, challange03, challange04, challange05"])
		print('usuário adicionado')
	
	update_star_textures(user_challanges)
	update_challange_sprite(user_challanges)
	
	#IMPLEMENTAÇÃO DAS TRADUÇÕES PARA OS DOIS IDIOMAS
	translator = preload("res://scripts/translation.gd").new()
	translator.load_translations()
	translator.set_language(query_result[0].language)
	
	$ColorRect/Label.text = "JavaScript: " + translator.get_translation("level") + " 1"
	pass

func update_challange_sprite(data):
	print(data)
	var challenges = data[0]
	for i in range(1, 6):
		var challenge_key = "challange0" + str(i)
		var texture_challange_name = get_node("Challange0" + str(i) + "/SpriteChallange0" + str(i))
		if challenges.has(challenge_key) and challenges[challenge_key] == "completed":
			print(i)
			print(texture_challange_name.texture)
			#texture_challange_name.texture = preload("res://assets/kenney_emotes-pack/PNG/Vector/Style 1/emote_star.png")
			
# FUNÇÃO QUE PREENCHE AS ESTRELAS CONFORME QUANTIDADE DE DESAFIOS COMPLETADOS
func update_star_textures(data):
	var challenges = data[0]
	var completed_count = 0
	
	for i in range(1, 6):
		var challenge_key = "challange0" + str(i)
		if challenges[challenge_key] == "completed":
			completed_count += 1
	
	for i in range(1, 6):
		var star = get_node("Star0" + str(i))
		if i <= completed_count:
			star.texture = preload("res://assets/icons/star-completed.png")
		else:
			star.texture = preload("res://assets/icons/star.png")
			
			
func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/settings.tscn")
	pass


func _on_texture_button_tips_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/buying_tips.tscn")
	pass
	

func alter_star() -> void:
	pass


func _on_texture_button_help_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/how_to_play.tscn")
	pass

func teste():
	print("Função teste() chamada do challange01!")
