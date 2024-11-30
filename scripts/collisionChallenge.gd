extends Area2D

@export_file("*.tscn") var overlay_scene = ""
@export var show_debug_name: String = ""
var player_in_area = false
var overlay_instance = null

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("interact"):
		show_overlay()
	elif Input.is_action_just_pressed("ui_cancel") and overlay_instance != null:
		close_overlay()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false

func show_overlay():
	if overlay_instance == null and !overlay_scene.is_empty():
		var scene = load(overlay_scene)
		overlay_instance = scene.instantiate()
		get_tree().root.add_child(overlay_instance)

func close_overlay():
	if overlay_instance != null:
		overlay_instance.queue_free()
		overlay_instance = null
