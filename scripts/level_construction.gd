extends Node2D

var database = SQLite
var user_id
var query_result

@onready var click = $ClickButton as AudioStreamPlayer

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	user_id = Global.user_id
	
	var condition = "id = '" + str(user_id) + "'"
	query_result = database.select_rows("users", condition, ["language, sounds, music"])
	
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
	if query_result[0].sounds == 1:
		click.play()
	else:
		click.stop()
	pass
