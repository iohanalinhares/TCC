extends Node2D

@onready var label: Label = $Label

func set_title(title_text: String):
	if label:
		label.text = title_text
	else:
		push_error("TitleLabel não encontrado!")
