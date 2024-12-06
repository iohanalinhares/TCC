extends Node2D

@onready var variables: ScrollContainer = $Variables
@onready var introdution: ScrollContainer = $Introdution
@onready var operators: ScrollContainer = $Operators
@onready var conditional_structure: ScrollContainer = $ConditionalStructure
@onready var loop_structure: ScrollContainer = $LoopStructure
@onready var functions: ScrollContainer = $Functions

@onready var step_1: Button = $HBoxContainer/Step1
@onready var step_2: Button = $HBoxContainer/Step2
@onready var step_3: Button = $HBoxContainer/Step3
@onready var step_4: Button = $HBoxContainer/Step4
@onready var step_5: Button = $HBoxContainer/Step5
@onready var step_6: Button = $HBoxContainer/Step6

@onready var next: Button = $Next
@onready var previous: Button = $Previous

@onready var click = $ClickButton as AudioStreamPlayer

var database = SQLite

var sections: Array[ScrollContainer] = []
var buttons: Array[Button] = []
var translator
var query_result

func _ready() -> void:
	sections = [introdution, variables, operators, conditional_structure, loop_structure, functions]
	buttons = [step_1, step_2, step_3, step_4, step_5, step_6]
	_change_button_color(0)
	
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	var user_id = Global.user_id
	
	var condition = "id = '" + str(user_id) + "'"
	query_result = database.select_rows("users", condition, ["money, language, sounds, music"])
	
	#IMPLEMENTAÇÃO DAS TRADUÇÕES PARA OS DOIS IDIOMAS
	translator = preload("res://scripts/translation.gd").new()
	translator.load_translations()
	translator.set_language(query_result[0].language)
	
	$Introdution/VBoxContainer/title.text = translator.get_translation("learn.topic01.title")
	$Introdution/VBoxContainer/content.text = translator.get_translation("learn.topic01.text")
	
	$Variables/VBoxContainer/title.text = translator.get_translation("learn.topic02.title")
	$Variables/VBoxContainer/content.text = translator.get_translation("learn.topic02.text")
	
	$Operators/VBoxContainer/title.text = translator.get_translation("learn.topic03.title")
	$Operators/VBoxContainer/content.text = translator.get_translation("learn.topic03.text")
	
	$ConditionalStructure/VBoxContainer/title.text = translator.get_translation("learn.topic04.title")
	$ConditionalStructure/VBoxContainer/content.text = translator.get_translation("learn.topic04.text")
	$ConditionalStructure/VBoxContainer/content2.text = translator.get_translation("learn.topic04.text2")
	
	$LoopStructure/VBoxContainer/title.text = translator.get_translation("learn.topic05.title")
	$LoopStructure/VBoxContainer/content.text = translator.get_translation("learn.topic05.text")
	$LoopStructure/VBoxContainer/titleFor.text = translator.get_translation("learn.topic05.titleFor")
	$LoopStructure/VBoxContainer/contentFor.text = translator.get_translation("learn.topic05.textFor")
	$LoopStructure/VBoxContainer/contentForComplement.text = translator.get_translation("learn.topic05.textForComplement")
	$LoopStructure/VBoxContainer/titleWhile.text = translator.get_translation("learn.topic05.titleWhile")
	$LoopStructure/VBoxContainer/contentWhile.text = translator.get_translation("learn.topic05.textWhile")
	$LoopStructure/VBoxContainer/contentWhileComplement.text = translator.get_translation("learn.topic05.textWhileComplement")
	$LoopStructure/VBoxContainer/titleDoWhile.text = translator.get_translation("learn.topic05.titleDoWhile")
	$LoopStructure/VBoxContainer/contentDoWhile.text = translator.get_translation("learn.topic05.textDoWhile")
	$LoopStructure/VBoxContainer/contentDoWhileComplement.text = translator.get_translation("learn.topic05.textDoWhileComplement")
	
	$Functions/VBoxContainer/title.text = translator.get_translation("learn.topic06.title")
	$Functions/VBoxContainer/content.text = translator.get_translation("learn.topic06.text")
	
	$Exit.text = translator.get_translation("buttons.leave")
	$Next.text = translator.get_translation("buttons.next")
	$Previous.text = translator.get_translation("buttons.previous")
	
	_update_navigation_buttons()

func _on_step_1_pressed() -> void:
	_hide_all_sections()
	introdution.visible = true
	_change_button_color(0)
	_update_navigation_buttons()
	pass


func _on_step_2_pressed() -> void:
	_hide_all_sections()
	variables.visible = true
	_change_button_color(1)
	_update_navigation_buttons()
	pass 


func _on_step_3_pressed() -> void:
	_hide_all_sections()
	operators.visible = true
	_change_button_color(2)
	_update_navigation_buttons()
	pass


func _on_step_4_pressed() -> void:
	_hide_all_sections()
	conditional_structure.visible = true
	_change_button_color(3)
	_update_navigation_buttons()
	pass


func _on_step_5_pressed() -> void:
	_hide_all_sections()
	loop_structure.visible = true
	_change_button_color(4)
	_update_navigation_buttons()
	pass


func _on_step_6_pressed() -> void:
	_hide_all_sections()
	functions.visible = true
	_change_button_color(5)
	_update_navigation_buttons()
	pass


#BOTÃO QUE VOLTA UMA PÁGINA
func _on_next_pressed() -> void:	
	for i in range(sections.size()):
		if sections[i].visible:
			if i == sections.size() - 1:
				queue_free()
			else:
				sections[i].visible = false
				sections[i + 1].visible = true
				_change_button_color(i + 1)
			_update_navigation_buttons()
			break
	pass


#BOTÃO QUE PASSA PARA A PRÓXIMA PÁGINA
func _on_previous_pressed() -> void:	
	for i in range(sections.size()):
		if sections[i].visible:
			if i > 0:
				sections[i].visible = false
				sections[i - 1].visible = true
				_change_button_color(i - 1)
			_update_navigation_buttons()
			break
	pass

#DESABILITA TODAS AS VISUALIZAÇÕES E DEIXA SOMENTE A SELECIONADA VISIVEL
func _hide_all_sections() -> void:
	for section in sections:
		section.visible = false
		
#MUDA A DOR DO BOTÃO PARA IDENTIFICAR O ITEM SELECIONADO
func _change_button_color(selected_index: int) -> void:
	for i in range(buttons.size()):
		buttons[i].modulate = Color(1, 1, 1)
	buttons[selected_index].modulate = Color(214, 177, 168)

#FAZ A VERIFICAÇÃO DOS ITENS PARA MUDAR O TEXTO OU DEIXAR BOTÃO VISÍVEL
func _update_navigation_buttons() -> void:
	for i in range(sections.size()):
		if sections[i].visible:
			if i == sections.size() - 1:
				next.text = translator.get_translation("buttons.conclude")
			else:
				next.text = translator.get_translation("buttons.next")
			previous.visible = i > 0
			break


func _on_exit_pressed() -> void:
	queue_free()
	pass


func _on_button_pressed() -> void:
	if query_result[0].sounds == 1:
		click.play()
	else:
		click.stop()
	pass
