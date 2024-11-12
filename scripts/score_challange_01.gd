extends Node2D

var database = SQLite
var money = 0
var user_id = 11
var resposta_selecionada = 0
var resposta_correta = 3
var condition
var query_result
var score = 50
var tips_result

var button_group = ButtonGroup.new()

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	condition = "id = '" + str(user_id) + "'"
	query_result = database.select_rows("users", condition, ["money"])
	var challange_result = database.select_rows("challanges", condition, ["challange01"])
	tips_result = database.select_rows("tips", condition, ["ai, tip, cards"])

	
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
	
	# DEFINIÇÃO DA QUANTIDADE DE DICAS DO USUÁRIO
	if tips_result:
		$QuantityHelp.text = str(tips_result[0].tip)
		$QuantityAI.text = str(tips_result[0].ai)
		$QuantityCards.text = str(tips_result[0].cards)
	else:
		$QuantityHelp.text = "0"
		$QuantityAI.text = "0"
		$QuantityCards.text = "0"
		
	# VERIFICA SE A QUANTIDADE DA DICA FOR 0 PARA DESABILIKTAR O BOTÃO
	if tips_result[0].tip == 0:
		$Help.disabled = true
		$Help.self_modulate = Color("7F7F7F")
	else:
		$Help.disabled = false
		
	if tips_result[0].ai == 0:
		$AI.disabled = true
		$AI.self_modulate = Color("7F7F7F")
	else:
		$AI.disabled = false
		
	if tips_result[0].cards == 0:
		$Cards.disabled = true
		$QuantityCards.self_modulate = Color("7F7F7F")
	else:
		$Cards.disabled = false
	pass


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
	$AIResponse/Introdution/VBoxContainer/AIReturn.text = "Carregando..."
	
	var request = "Sem me dar a respostga correta, me dê uma dica sobre a resposta correta:
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
	pass


func _on_ok_pressed() -> void:
	$AIResponse.visible = false
	pass


func _on_ai_pressed() -> void:
	$AIResponse/Introdution/VBoxContainer/AIReturn.text = "Carregando..."
	
	var request = "Me dê a alternativa correta e uma explicação dela:
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
	pass


func _on_cards_pressed() -> void:
	$MarginContainer/VBoxContainer/Option_01.disabled = true
	$MarginContainer/VBoxContainer/Option_04.disabled = true
	
	var cards = tips_result[0].cards
	var update_data = {"cards": cards - 1}
	var update_result = database.update_rows("tips", condition, update_data)
	pass
