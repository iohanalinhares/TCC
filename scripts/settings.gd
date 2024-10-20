extends Node2D

var database = SQLite
func _ready() -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	var user_id = Global.user_id
	
	var condition = "id = '" + str(user_id) + "'"
	var query_result = database.select_rows("users", condition, ["id, username, sounds, music, language"])
	
	var languege = $"Language/selected-language"
	var username = $"Username/selected-username"
	
	print(query_result[0].music == 1)
	
	languege.text = query_result[0].language
	username.text = query_result[0].username
	pass

func _on_back_button_down() -> void:
	get_tree().change_scene_to_file("res://levels/world_01.tscn")
	pass

func _on_save_button_down() -> void:
	pass


func _on_check_button_pressed() -> void:
	pass
