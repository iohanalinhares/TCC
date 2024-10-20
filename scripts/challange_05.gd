extends Node2D

@onready var colision_challange_01: Area2D = $"."

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and WindowManager.current_window:
		WindowManager.close_current_window()
	elif colision_challange_01.get_overlapping_bodies().size() > 0 and event.is_action_pressed("interact"):
		WindowManager.close_current_window()

		var balloon_scene = preload("res://levels/challenge_5.tscn")
		var new_window = balloon_scene.instantiate()
		add_child(new_window)
		WindowManager.current_window = new_window
