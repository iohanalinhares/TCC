extends Node2D

@onready var quantity_help_label = $QuantityHelp
@onready var quantity_ai_label = $QuantityAI
@onready var quantity_cards_label = $QuantityCards

var database = SQLite
var money = 0
var resposta_selecionada = 0
var resposta_correta = 3
var condition
var query_result
var score = 50
var tips_result
var translator
var user_id

var button_group = ButtonGroup.new()

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	user_id = Global.user_id
	
	condition = "id = '" + str(user_id) + "'"
	query_result = database.select_rows("users", condition, ["money, language"])
	var challange_result = database.select_rows("challanges", condition, ["challange01"])
	
	#IMPLEMENTAÇÃO DAS TRADUÇÕES PARA OS DOIS IDIOMAS
	translator = preload("res://scripts/translation.gd").new()
	translator.load_translations()
	translator.set_language(query_result[0].language)
	
	$Title/title.text = translator.get_translation("challanges.challange01.title")
	$MarginContainer/VBoxContainer/Label.text = translator.get_translation("challanges.challange01.question")
	$Save.text = translator.get_translation("buttons.save")
	$Back.text = translator.get_translation("buttons.back")
	
	$IncorrectAnswer/Label.text = translator.get_translation("incorrectAnswer")
	$IncorrectAnswer/TryAgain.text = translator.get_translation("buttons.tryAgain")
	
	$ConcludedChallange/Label.text = translator.get_translation("challangeCompleted")
	
	$AIResponse/Introdution/VBoxContainer/AIReturn.text = translator.get_translation("loading")

	if challange_result && challange_result[0].challange01 == "not_completed":
		$ConcludedChallange.visible = false
	else:
		$ConcludedChallange.visible = true
	
	# ENVIO DE RESPOSTAS DOS BOTÕES
	var button1 = $MarginContainer/VBoxContainer/Option_01
	var button2 = $MarginContainer/VBoxContainer/Option_02
	var button3 = $MarginContainer/VBoxContainer/Option_03
	var button4 = $MarginContainer/VBoxContainer/Option_04

	button1.pressed.connect(func(): resposta_selecionada = 1)
	button2.pressed.connect(func(): resposta_selecionada = 2)
	button3.pressed.connect(func(): resposta_selecionada = 3)
	button4.pressed.connect(func(): resposta_selecionada = 4)
	
	atualizar_quantidade_dicas()
	pass

func atualizar_quantidade_dicas():
	condition = "id = '" + str(user_id) + "'"
	tips_result = database.select_rows("tips", condition, ["ai, tip, cards"])
	
	var insert_table = """
		INSERT INTO tips (id, ai, tip, cards)
		VALUES(?, ?, ?, ?)
	"""
		
	# VERIFICA SE O USUÁRIO EXISTE NA TABLE OU SE É PRECISO CRIAR UM ITEM DELE
	if !tips_result:
		var values = [user_id, 0, 1, 1]
		database.query_with_bindings(insert_table, values)
		tips_result = database.select_rows("tips", condition, ["id, ai, tip, cards"])
		print('usuário adicionado em tips')
	
	# POPULA O LABEL COM A QUANTIDADE ENCONTRADA NO BANCO
	quantity_help_label.text = str(tips_result[0].tip)
	quantity_ai_label.text = str(tips_result[0].ai)
	quantity_cards_label.text = str(tips_result[0].cards)
	
	# VERIFICA SE A QUANTIDADE DA DICA FOR 0 PARA DESABILITAR O BOTÃO
	if tips_result[0].tip == 0:
		$Help.disabled = true
		$QuantityHelp.self_modulate = Color("7F7F7F")
	else:
		$Help.disabled = false
		
	if tips_result[0].ai == 0:
		$AI.disabled = true
		$QuantityAI.self_modulate = Color("7F7F7F")
	else:
		$AI.disabled = false
		
	if tips_result[0].cards == 0:
		$Cards.disabled = true
		$QuantityCards.self_modulate = Color("7F7F7F")
	else:
		$Cards.disabled = false
	pass

const WorldConnection = preload("res://scripts/databaseConnection.gd")

func _on_save_pressed() -> void:	
	if resposta_selecionada != 0:
		verificar_resposta(resposta_selecionada)
	else:
		print("Nenhuma resposta selecionada!")
	pass


func verificar_resposta(numero_resposta):
	if numero_resposta == resposta_correta:
		money = query_result[0].money + score
		
		var update_data = {"money": money}
		var update_result = database.update_rows("users", condition, update_data)
		print("Resposta correta!")
		
		var challange_completed = database.update_rows("challanges", condition, {"challange01": "completed"})
		$ConcludedChallange.visible = true
		$IncorrectAnswer.visible = false
		
		var user_challanges = database.select_rows("challanges", condition, ["id, level, challange01, challange02, challange03, challange04, challange05"])
		var world_instance = WorldConnection.new()
		world_instance.update_challange_sprite(user_challanges)
		
		database.close_db()
	else:
		score = score - 10
		$IncorrectAnswer.visible = true
		print("Resposta incorreta!")


func _on_back_pressed() -> void:
	queue_free()
	pass


func _on_confirm_pressed() -> void:
	queue_free()
	pass


func _on_try_again_pressed() -> void:
	$IncorrectAnswer.visible = false
	pass


func _on_help_pressed() -> void:
	$AIResponse/Introdution/VBoxContainer/AIReturn.text = translator.get_translation("loading")
	
	var request = "Sem me dar a resposta correta, me dê uma dica sobre a questão no idioma:" + query_result[0].language + "
		1.	Qual será o resultado do seguinte código?
		let a = 10;
		let b = 20;
		let resultado = a + b;
		console.log(resultado);
		A) 10
		B) 20
		C) 30
		D) undefined
	"
	
	$AIResponse.visible = true
	GeminiRequest.make_gemini_request(request, $AIResponse/Introdution/VBoxContainer/AIReturn)
	
	var tip = tips_result[0].tip
	var update_data = {"tip": tip - 1}
	var update_result = database.update_rows("tips", condition, update_data)
	atualizar_quantidade_dicas()
	pass


func _on_ok_pressed() -> void:
	$AIResponse.visible = false
	pass


func _on_ai_pressed() -> void:
	$AIResponse/Introdution/VBoxContainer/AIReturn.text = translator.get_translation("loading")
	
	var request = "Me dê a alternativa correta e uma explicação dela no idioma:" + query_result[0].language + "
		1.	Qual será o resultado do seguinte código?
		let a = 10;
		let b = 20;
		let resultado = a + b;
		console.log(resultado);
		A) 10
		B) 20
		C) 30
		D) undefined
	"
	$AIResponse.visible = true
	GeminiRequest.make_gemini_request(request, $AIResponse/Introdution/VBoxContainer/AIReturn)
	
	var ai = tips_result[0].ai
	var update_data = {"ai": ai - 1}
	var update_result = database.update_rows("tips", condition, update_data)
	atualizar_quantidade_dicas()
	pass


func _on_cards_pressed() -> void:
	$MarginContainer/VBoxContainer/Option_01.disabled = true
	$MarginContainer/VBoxContainer/Option_04.disabled = true
	
	var cards = tips_result[0].cards
	var update_data = {"cards": cards - 1}
	var update_result = database.update_rows("tips", condition, update_data)
	atualizar_quantidade_dicas()
	pass
