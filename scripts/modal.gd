extends Node2D

var database = SQLite

@onready var label: Label = $Label
@onready var money_label: Label = $Money
@onready var cancel_button: Button = $Cancel
@onready var click = $ClickButton as AudioStreamPlayer

var tips_result
var query_result
var condition
var typeButtonPressed
var translator

func _ready():
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	var user_id = Global.user_id
	
	condition = "id = '" + str(user_id) + "'"
	tips_result = database.select_rows("tips", condition, ["ai, tip, cards"])
	query_result = database.select_rows("users", condition, ["language, money, sounds, music"])
	cancel_button.pressed.connect(_on_cancel_pressed)
	
	#IMPLEMENTAÇÃO DAS TRADUÇÕES PARA OS DOIS IDIOMAS
	translator = preload("res://scripts/translation.gd").new()
	translator.load_translations()
	translator.set_language(query_result[0].language)
	
	$Title.text = translator.get_translation("confirmPurchase") + ": "
	$Cancel.text = translator.get_translation("buttons.cancel")
	$Confirm.text = translator.get_translation("buttons.confirm")

func set_title(title_text: String):
	if label:
		label.text = title_text
	else:
		push_error("title_text não encontrado!")

func set_money(money: int):
	if label:
		money_label.text = "$" + str(money)
	else:
		push_error("money_label não encontrado!")


func _on_cancel_pressed() -> void:
	queue_free()
	pass
	
func set_type(type: String):
	typeButtonPressed = type

func _on_confirm_pressed():
	var update_result
	match typeButtonPressed:
		'ai':
			var ai = tips_result[0].ai
			var update_data = {"ai": ai + 1}
			update_result = database.update_rows("tips", condition, update_data)
			
			var update_money = {"money": query_result[0].money - 80}
			database.update_rows("users", condition, update_money)
		'tip':
			var tip = tips_result[0].tip
			var update_data = {"tip": tip + 1}
			update_result = database.update_rows("tips", condition, update_data)
			
			var update_money = {"money": query_result[0].money - 40}
			database.update_rows("users", condition, update_money)
		'cards':
			var cards = tips_result[0].cards
			var update_data = {"cards": cards + 1}
			update_result = database.update_rows("tips", condition, update_data)
			
			var update_money = {"money": query_result[0].money - 20}
			database.update_rows("users", condition, update_money)
		'combo':
			var ai = tips_result[0].ai
			var tip = tips_result[0].tip
			var cards = tips_result[0].cards
			var update_data = {
				"ai": ai + 1,
				"tip": tip + 1,
				"cards": cards + 1
			}
			update_result = database.update_rows("tips", condition, update_data)
			
			var update_money = {"money": query_result[0].money - 120}
			database.update_rows("users", condition, update_money)
		'combo_ai':
			var ai = tips_result[0].ai
			var update_data = {"ai": ai + 3}
			update_result = database.update_rows("tips", condition, update_data)
			
			var update_money = {"money": query_result[0].money - 220}
			database.update_rows("users", condition, update_money)
		'combo_tips':
			var tip = tips_result[0].tip
			var update_data = {"tip": tip + 3}
			update_result = database.update_rows("tips", condition, update_data)
			
			var update_money = {"money": query_result[0].money - 100}
			database.update_rows("users", condition, update_money)
	
	if update_result:
		queue_free()
	pass


func _on_button_pressed() -> void:
	if query_result[0].sounds == 1:
		click.play()
	else:
		click.stop()
	pass
