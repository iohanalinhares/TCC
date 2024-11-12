extends Node2D

var database = SQLite
var money = 0
var user_id = 11
var resposta_selecionada = 0
var resposta_correta = 2
var condition
var query_result
var score = 50

var button_group = ButtonGroup.new()

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	condition = "id = '" + str(user_id) + "'"
	query_result = database.select_rows("users", condition, ["money"])
	var challange_result = database.select_rows("challanges", condition, ["challange02"])
	
	if challange_result && challange_result[0].challange02 == "not_completed":
		$ConcludedChallange.visible = false
	else:
		$ConcludedChallange.visible = true
	
	var button1 = $MarginContainer/VBoxContainer/Option_01
	var button2 = $MarginContainer/VBoxContainer/Option_02
	var button3 = $MarginContainer/VBoxContainer/Option_03
	var button4 = $MarginContainer/VBoxContainer/Option_04

	button1.pressed.connect(func(): resposta_selecionada = 1)
	button2.pressed.connect(func(): resposta_selecionada = 2)
	button3.pressed.connect(func(): resposta_selecionada = 3)
	button4.pressed.connect(func(): resposta_selecionada = 4)
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
		
		var challange_completed = database.update_rows("challanges", condition, {"challange02": "completed"})
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
	var request = "Sem me dar a respostga correta, me dê uma dica sobre a resposta correta:
		O que será exibido no console ao rodar o código abaixo?
		let idade = 17;
		if (idade >= 18) {
		  console.log('Você pode votar.');
		} else {
		  console.log('Você ainda não pode votar.');
		}
		A) Você pode votar.
		B) Você ainda não pode votar.
		C) undefined
		D) O código não funciona porque falta o ponto e vírgula.
	"
	
	GeminiRequest.make_gemini_request(request)
	pass
	


func _on_ok_pressed() -> void:
	$AIResponse.visible = false
	pass
