extends Node2D

func _unhandled_input(event):
	var area = $"."
	
	# Debug para ver qual área está sendo ativada
	if area.get_overlapping_bodies().size() > 0:
		print("Área ativa: ", area.get_path())
	
	if event.is_action_pressed("ui_cancel") and WindowManager.current_window:
		WindowManager.close_current_window()
	elif area.get_overlapping_bodies().size() > 0 and event.is_action_pressed("interact"):
		WindowManager.close_current_window()
		
		var balloon_scene
		# Pega o nome do nó pai para identificar qual área é
		var parent_name = area.get_parent().name
		
		match parent_name:
			"Learn":
				balloon_scene = preload("res://levels/learn.tscn")
			"Challange01":
				balloon_scene = preload("res://levels/challenge_1.tscn")
			"Challange02":
				balloon_scene = preload("res://levels/challenge_2.tscn")
			"Challange03":
				balloon_scene = preload("res://levels/challenge_3.tscn")
			"Challange04":
				balloon_scene = preload("res://levels/challenge_4.tscn")
			"Challange05":
				balloon_scene = preload("res://levels/challenge_5.tscn")
			
		if balloon_scene:
			var new_window = balloon_scene.instantiate()
			add_child(new_window)
			WindowManager.current_window = new_window
			print(balloon_scene.instantiate())
