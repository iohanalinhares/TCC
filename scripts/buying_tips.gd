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
	
	# VERIFICA SE O USUÁRIO EXISTE NA TABLE OU SE É PRECISO CRIAR UM ITEM DELE
	if user_tips:
		print('usuário existe')
	else:
		var values = [user_id, 1, 3, 3]
		user_tips = database.query_with_bindings(insert_table, values)
		print('usuário adicionado')
	
	# VERIFICA SE O USUÁRIO TEM PONTOS, SE NÃO TIVER SETA COMO 0
	var query_result = database.select_rows("users", condition, ["money"])
	var money = $"Money"
	if query_result:
		money.text = str(query_result[0].money)
	else:
		money.text = "0"
	pass
	
	if int(money.text) < 80:
		$ColorRect2/Button.disabled = true
	else:
		$ColorRect2/Button.disabled = false
		
	if int(money.text) < 40:
		$ColorRect3/Button.disabled = true
	else:
		$ColorRect3/Button.disabled = false
		
	if int(money.text) < 20:
		$ColorRect4/Button.disabled = true
	else:
		$ColorRect4/Button.disabled = false
		
	if int(money.text) < 120:
		$ColorRect5/Button.disabled = true
	else:
		$ColorRect5/Button.disabled = false
		
	if int(money.text) < 220:
		$ColorRect6/Button.disabled = true
	else:
		$ColorRect6/Button.disabled = false
		
	if int(money.text) < 100:
		$ColorRect7/Button.disabled = true
	else:
		$ColorRect7/Button.disabled = false

func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/world_01.tscn")
	pass


var dynamic_scene = preload("res://levels/modal.tscn")
var current_scene = null

# CARREGA A CENA DE COMPRA DE NOVAS DICAS
func load_dynamic_scene(title: String, money: int, typeButtonPressed: String):
	if current_scene != null:
		current_scene.queue_free()
	
	current_scene = dynamic_scene.instantiate()
	$Node2D.add_child(current_scene)
	await get_tree().create_timer(0).timeout
	
	current_scene.set_title(title)
	current_scene.set_money(money)
	current_scene.set_type(typeButtonPressed)
	
# ENVIO DE INFORMAÇÕES PARA O MODAL DE CONFIRMAÇÃO DE COMPRA
func _on_button_ai_pressed() -> void:
	load_dynamic_scene("1 resposta de IA", 80, "ai")
	pass


func _on_button_tip_pressed() -> void:
	load_dynamic_scene("1 dica", 40, "tip")
	pass


func _on_button_cards_pressed() -> void:
	load_dynamic_scene("1 dica eliminando opções", 20, "cards")
	pass


func _on_button_combo_pressed() -> void:
	load_dynamic_scene("1 combo com todas as ajudas", 120, "combo")
	pass


func _on_button_ai_3x_pressed() -> void:
	load_dynamic_scene("3 respostas de IA", 220, "combo_ai")
	pass


func _on_button_tips_3x_pressed() -> void:
	load_dynamic_scene("3 dicas", 100, "combo_tips")
	pass

# FIM DO ENVIO DE INFORMAÇÕES PARA O MODAL DE CONFIRMAÇÃO DE COMPRA
