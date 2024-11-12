extends Node2D

var database = SQLite

func _ready():
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	var user_id = Global.user_id
	
	var condition = "id = '" + str(user_id) + "'"
	
	var query_result = database.select_rows("users", condition, ["money"])
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
	
	var user_tips = database.select_rows("challanges", condition, ["id"])
	
	# VERIFICA SE O USUÁRIO EXISTE NA TABLE OU SE É PRECISO CRIAR UM ITEM DELE
	if user_tips:
		print('usuário existe')
	else:
		var values = [user_id, 1, "not_completed", "not_completed", "not_completed", "not_completed", "not_completed"]
		user_tips = database.query_with_bindings(insert_table, values)
		print('usuário adicionado')
	pass
	

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/settings.tscn")
	pass


func _on_texture_button_tips_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/buying_tips.tscn")
	pass
	

func alter_star() -> void:
	pass
