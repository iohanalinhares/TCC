extends Node

var translations = {}
var current_language = "portuguese"

func load_translations():
	var file = FileAccess.open("res://translation/translations.json", FileAccess.READ)
	if file:
		var text = file.get_as_text()
		translations = JSON.parse_string(text)
	else:
		print("Arquivo de tradução não encontrado.")

func set_language(language_code: String):
	if language_code in translations:
		current_language = language_code
	else:
		print("Idioma não encontrado nas traduções.")

func get_translation(key: String) -> String:
	var keys = key.split(".")
	var value = translations.get(current_language, {})
	
	for sub_key in keys:
		if sub_key in value:
			value = value[sub_key]
		else:
			return key
	return value
