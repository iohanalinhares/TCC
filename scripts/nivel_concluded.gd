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
	query_result = database.select_rows("users", condition, ["money, language, sounds, music"])
	
	$money.text = str(query_result[0].money)
	
	#IMPLEMENTAÇÃO DAS TRADUÇÕES PARA OS DOIS IDIOMAS
	var translator = preload("res://scripts/translation.gd").new()
	translator.load_translations()
	translator.set_language(query_result[0].language)
	
	$Congratulations.text = translator.get_translation("congratulations")
	$Concluded.text = translator.get_translation("nivelConcluded")
	$NextLevel.text = translator.get_translation("buttons.nextLevel")
	pass


func _on_next_level_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_construction.tscn")
	if query_result[0].sounds == 1:
		click.play()
	else:
		click.stop()
	pass
