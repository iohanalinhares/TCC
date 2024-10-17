extends Node2D

@onready var area_2d: Area2D = $ColisionChallange01

func _unhandled_input(event):
	if area_2d.get_overlapping_bodies().size() > 0 && event.is_action_pressed("interact"):
		var balloon_scene = preload("res://levels/challenge.tscn")
		var balloon_instance = balloon_scene.instantiate()
		add_child(balloon_instance)
