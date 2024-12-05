extends Node2D

var database = SQLite
var user_id

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	user_id = Global.user_id
	
	var condition = "id = '" + str(user_id) + "'"
	var query_result = database.select_rows("users", condition, ["language"])
	
	#IMPLEMENTAÇÃO DAS TRADUÇÕES PARA OS DOIS IDIOMAS
	var translator = preload("res://scripts/translation.gd").new()
	translator.load_translations()
	translator.set_language(query_result[0].language)
	
	$Message.text = translator.get_translation("nextLevelConstruction")
	$Back.text = translator.get_translation("buttons.backToLogin")
	pass


func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/login.tscn")
	pass
