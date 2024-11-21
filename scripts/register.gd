extends Node2D

var database : SQLite
func _ready() -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	$"Password/input-password".secret = true
	$"ConfirmPassword/input-confirm-password".secret = true
	
	pass

func _process(delta: float) -> void:
	pass

func _on_register_button_button_down() -> void:
	var username = $"Username/input-name".text
	var password = $"Password/input-password".text
	var confirmPassword = $"ConfirmPassword/input-confirm-password".text
	var language = $"Language/OptionButton".get_selected_id()
	var alert_username = $"required-username"
	var alert_password = $"required-password"
	var alert_confirm_password = $"required-confirm-password"
	
	# VERIFICA SE OS CAMPOS FORAM PREENCHIDOS
	# NOME DE USUÁRIO
	if username.strip_edges() == "":
		alert_username.visible = true
		return
	else:
		alert_username.visible = false
		
	# SENHA
	if password.strip_edges() == "":
		alert_password.visible = true
		return
	else:
		alert_password.visible = false
	
	# CONFIRMAÇÃO DE SENHA
	if confirmPassword.strip_edges() == "":
		alert_confirm_password.visible = true
		return
	elif confirmPassword != password:
		alert_confirm_password.text = "As senhas devem ser iguais!"
		alert_confirm_password.visible = true
		return
	else:
		alert_confirm_password.visible = false
		
	
	# PASSA A SENHA PARA A FUNÇÃO DE CRIPTOGRAFIA
	var hashed_password = hash_password(password)
	
	# VERIFICA SE O USUÁRIO EXISTE
	var condition = "username = '" + username + "'"
	var query_result = database.select_rows("users", condition, ["username"])
	
	if query_result.size() > 0:
		var alert_label = $"user-exists"
		alert_label.visible = true
		return
	# FIM DA VERIFICAÇÃO
	
	#VERIFICAÇÃO DO IDIOMA SELECIONADO
	if language:
		if language == 1:
			language = 'portuguese'
		else:
			language = 'english'
		
	var data = {
		"username": $"Username/input-name".text,
		"password": hashed_password,
		"money": 0,
		"level": 1,
		"language": language,
		"sounds": true,
		"music": true,
	}
	
	database.insert_row("users", data)
	
	get_tree().change_scene_to_file("res://levels/world_01.tscn")
	pass

func _on_loginbutton_button_down() -> void:
	get_tree().change_scene_to_file("res://levels/login.tscn")
	pass
	
# CRIPTOGRAFA A SENHA PARA SALVAR NO BANCO
func hash_password(password: String) -> String:
	var ctx = HashingContext.new()
	ctx.start(HashingContext.HASH_SHA256)
	ctx.update(password.to_utf8_buffer())
	var hashed_password = ctx.finish().hex_encode()
	return hashed_password
