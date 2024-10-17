extends Node2D

var database = SQLite
func _ready() -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	$"Password/input-password".secret = true
	pass

func _process(delta: float) -> void:
	pass

func _on_newuserbutton_button_down() -> void:
	get_tree().change_scene_to_file("res://levels/register.tscn")
	pass

func _on_login_button_down() -> void:
	var username = $"Username/input-name".text
	var password = $"Password/input-password".text
	var alert_username = $"required-username"
	var alert_password = $"required-password"
	var incorrect_user_password = $"incorrect-user-password"
	
	if username.strip_edges() == "":
		alert_username.visible = true
		return
	else:
		alert_username.visible = false
		
	if password.strip_edges() == "":
		alert_password.visible = true
		return
	else:
		alert_password.visible = false
		
	var condition = "username = '" + username + "'"
	var query_result = database.select_rows("users", condition, ["id, username, password"])
	
	if(query_result.size() > 0):
		var verifyReturn = verify_password(query_result[0].password, password)
		
		if(verifyReturn == true):
			get_tree().change_scene_to_file("res://levels/world_01.tscn")
			Global.user_id = query_result[0].id
			print(Global.user_id)
		else:
			incorrect_user_password.text = "Usuário ou senha incorretos!"
			incorrect_user_password.visible = true
	else:
		incorrect_user_password.text = "Este usuário não existe!"
		incorrect_user_password.visible = true
		
	pass
	
func hash_password(password: String) -> String:
	var ctx = HashingContext.new()
	ctx.start(HashingContext.HASH_SHA256)
	ctx.update(password.to_utf8_buffer())
	var hashed_password = ctx.finish().hex_encode()
	return hashed_password
	
func verify_password(hashed_password: String, entered_password: String) -> bool:
	var entered_password_hash = hash_password(entered_password)
	return hashed_password == entered_password_hash
