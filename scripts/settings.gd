extends Node2D

var database = SQLite
var translator
var language
var query_result
var condition

@onready var click = $ClickButton as AudioStreamPlayer
@onready var check_button_music = $Music/CheckButton
@onready var check_button_sounds = $Sons/CheckButton

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	var user_id = Global.user_id
	
	condition = "id = '" + str(user_id) + "'"
	query_result = database.select_rows("users", condition, ["id, username, sounds, music, language"])
	
	var languege = $"Language/selected-language"
	var username = $"Username/selected-username"
	
	languege.text = query_result[0].language
	username.text = query_result[0].username
	
	if query_result[0].language:
		if query_result[0].language == 'portuguese':
			$"Language/OptionButton".select(0)
		else:
			$"Language/OptionButton".select(1)
			
	if query_result[0].music == 1:
		check_button_music.set_pressed(true)
	else:
		check_button_music.set_pressed(false)
		
	if query_result[0].sounds == 1:
		check_button_sounds.set_pressed(true)
	else:
		check_button_sounds.set_pressed(false)
	
	#IMPLEMENTAÇÃO DAS TRADUÇÕES PARA OS DOIS IDIOMAS
	translator = preload("res://scripts/translation.gd").new()
	translator.load_translations()
	translator.set_language(query_result[0].language)
	
	$Title/title.text = translator.get_translation("configuration")
	$Sons/CheckButton.text = translator.get_translation("sounds") + ": "
	$Music/CheckButton.text = translator.get_translation("music") + ": "
	$Language/languege.text = translator.get_translation("language") + ": "
	$Username/username.text = translator.get_translation("username") + ": "
	$Save.text = translator.get_translation("buttons.save")
	$Back.text = translator.get_translation("buttons.back")
	pass

func _on_back_button_down() -> void:
	get_tree().change_scene_to_file("res://levels/world_01.tscn")
	pass

func _on_save_button_down() -> void:
	var updatedLanguage
	if $"Language/OptionButton".get_selected_id():
		if $"Language/OptionButton".get_selected_id() == 1:
			updatedLanguage = 'portuguese'
		else:
			updatedLanguage = 'english'
			
	var updated_checkbutton_music
	if check_button_music.is_pressed():
		updated_checkbutton_music = 1
	else:
		updated_checkbutton_music = 0
		
	var updated_checkbutton_sounds
	if check_button_sounds.is_pressed():
		updated_checkbutton_sounds = 1
	else:
		updated_checkbutton_sounds = 0
		
	var update_data = {"language": updatedLanguage, "music": updated_checkbutton_music, "sounds": updated_checkbutton_sounds}
	var update_result = database.update_rows("users", condition, update_data)
	
	if update_result:
		get_tree().change_scene_to_file("res://levels/world_01.tscn")
		
	pass


func _on_check_button_pressed() -> void:
	pass


func _on_button_pressed() -> void:
	if query_result[0].sounds == 1:
		click.play()
	else:
		click.stop()
	pass
