extends Node2D

var database : SQLite

func _ready():
	pass
	
func _on_settings_button_down() -> void:
	get_tree().change_scene_to_file("res://levels/settings.tscn")
	pass
