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
	pass
	

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/settings.tscn")
	pass


func _on_texture_button_tips_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/buying_tips.tscn")
	pass
