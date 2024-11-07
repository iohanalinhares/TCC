extends Node2D

var database = SQLite

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	#var user_id = Global.user_id
	var user_id = 11
	
	var insert_table = """
		INSERT INTO tips (id, ai, tip, cards)
		VALUES(?, ?, ?, ?)
	"""
	
	var condition = "id = '" + str(user_id) + "'"
	var user_tips = database.select_rows("tips", condition, ["id"])
	
	if user_tips:
		print('usuário existe')
	else:
		var values = [user_id, 1, 3, 3]
		user_tips = database.query_with_bindings(insert_table, values)
		print('usuário adicionado')
	
	
	var query_result = database.select_rows("users", condition, ["money"])
	var money = $"Money"
	if query_result:
		money.text = str(query_result[0].money)
	else:
		money.text = "0"
	pass


func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/world_01.tscn")
	pass


var dynamic_scene = preload("res://levels/modal.tscn") # Caminho para sua cena
var current_scene = null

func load_dynamic_scene(title: String):
	if current_scene != null:
		current_scene.queue_free()
	
	current_scene = dynamic_scene.instantiate()
	current_scene.set_title(title)
	$SceneContainer.add_child(current_scene)
	
	
func _on_button_ai_pressed() -> void:
	load_dynamic_scene("Título 1")
	pass
