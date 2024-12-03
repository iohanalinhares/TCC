extends Node2D

var database = SQLite
var translator
var dynamic_scene = preload("res://levels/modal.tscn")
var current_scene = null
var money
var user_id

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	user_id = Global.user_id
	
	var insert_table = """
		INSERT INTO tips (id, ai, tip, cards)
		VALUES(?, ?, ?, ?)
	"""
	
	var condition = "id = '" + str(user_id) + "'"
	var user_tips = database.select_rows("tips", condition, ["id"])
	var query_result = database.select_rows("users", condition, ["money, language"])
	
	#IMPLEMENTAÇÃO DAS TRADUÇÕES PARA OS DOIS IDIOMAS
	translator = preload("res://scripts/translation.gd").new()
	translator.load_translations()
	translator.set_language(query_result[0].language)
	
	$Title/Title.text = translator.get_translation("tipsStore")
	$Back.text = translator.get_translation("buttons.back")
	
	# VERIFICA SE O USUÁRIO EXISTE NA TABLE OU SE É PRECISO CRIAR UM ITEM DELE
	if !user_tips:
		var values = [user_id, 1, 3, 3]
		user_tips = database.query_with_bindings(insert_table, values)
		print('usuário adicionado')
		
	select_money()
	validacao_de_compra()
	
func select_money():
	var condition = "id = '" + str(user_id) + "'"
	var query_result = database.select_rows("users", condition, ["money, language"])
	
	# VERIFICA SE O USUÁRIO TEM PONTOS, SE NÃO TIVER SETA COMO 0
	money = $"Money"
	if query_result:
		money.text = str(query_result[0].money)
	else:
		money.text = "0"
	pass
	
func validacao_de_compra():
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
	

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/world_01.tscn")
	pass


# CARREGA A CENA DE COMPRA DE NOVAS DICAS
func load_dynamic_scene(title: String, money: int, typeButtonPressed: String):
	if current_scene != null:
		current_scene.queue_free()
		await current_scene.to_signal("tree_exited")
		select_money()
	
	current_scene = dynamic_scene.instantiate()
	$Node2D.add_child(current_scene)
	await get_tree().create_timer(0).timeout
	
	current_scene.set_title(title)
	current_scene.set_money(money)
	current_scene.set_type(typeButtonPressed)
	
# ENVIO DE INFORMAÇÕES PARA O MODAL DE CONFIRMAÇÃO DE COMPRA
func _on_button_ai_pressed() -> void:
	load_dynamic_scene(translator.get_translation("tips.ai"), 80, "ai")
	pass


func _on_button_tip_pressed() -> void:
	load_dynamic_scene(translator.get_translation("tips.tip"), 40, "tip")
	pass


func _on_button_cards_pressed() -> void:
	load_dynamic_scene(translator.get_translation("tips.cards"), 20, "cards")
	pass


func _on_button_combo_pressed() -> void:
	load_dynamic_scene(translator.get_translation("tips.comboAll"), 120, "combo")
	pass


func _on_button_ai_3x_pressed() -> void:
	load_dynamic_scene(translator.get_translation("tips.comboAi"), 220, "combo_ai")
	pass


func _on_button_tips_3x_pressed() -> void:
	load_dynamic_scene(translator.get_translation("tips.comboTips"), 100, "combo_tips")
	pass

# FIM DO ENVIO DE INFORMAÇÕES PARA O MODAL DE CONFIRMAÇÃO DE COMPRA
