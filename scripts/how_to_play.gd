extends Node2D

var database = SQLite
var translator

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	var user_id = Global.user_id
	var condition = "id = '" + str(user_id) + "'"
	var query_result = database.select_rows("users", condition, ["language"])
	
	#IMPLEMENTAÇÃO DAS TRADUÇÕES PARA OS DOIS IDIOMAS
	translator = preload("res://scripts/translation.gd").new()
	translator.load_translations()
	translator.set_language(query_result[0].language)
	
	$Title/Title.text = translator.get_translation("help.title")
	
	$ColorRectBorderSpace/Title.text = translator.get_translation("help.space.title")
	$ColorRectBorderSpace/Description.text = translator.get_translation("help.space.description")
	$ColorRectBorderEsc/Title.text = translator.get_translation("help.esc.title")
	$ColorRectBorderEsc/Description.text = translator.get_translation("help.esc.description")
	$ColorRectBorderDown/Title.text = translator.get_translation("help.down.title")
	$ColorRectBorderDown/Description.text = translator.get_translation("help.down.description")
	$ColorRectBorderLeft/Title.text = translator.get_translation("help.left.title")
	$ColorRectBorderLeft/Description.text = translator.get_translation("help.left.description")
	$ColorRectBorderRight/Title.text = translator.get_translation("help.right.title")
	$ColorRectBorderRight/Description.text = translator.get_translation("help.right.description")
	$ColorRectBorderUp/Title.text = translator.get_translation("help.up.title")
	$ColorRectBorderUp/Description.text = translator.get_translation("help.up.description")
	
	$Back.text = translator.get_translation("buttons.conclude")
	
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/world_01.tscn")
	pass
