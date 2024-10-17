extends Node2D

@onready var area_learn: Area2D = $AreaLearn

var balloon_instance = null

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and balloon_instance:
		balloon_instance.queue_free()
		balloon_instance = null
	elif area_learn.get_overlapping_bodies().size() > 0 and event.is_action_pressed("interact"):
		if balloon_instance == null:
			var balloon_scene = preload("res://levels/learn.tscn")
			balloon_instance = balloon_scene.instantiate()
			add_child(balloon_instance)
