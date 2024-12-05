extends Node2D

var database : SQLite
func _ready() -> void:
	database = SQLite.new()
	database.path = "res://database/database.db"
	database.open_db()
	
	$"Password/input-password".secret = true
	$"ConfirmPassword/input-confirm-password".secret = true
	$Language/OptionButton.selected = 0
	
	# MUDA O FOCO DO INPUT A PARTIR DO TAB
	$"Username/input-name".grab_focus()
	$"Username/input-name".focus_next = $"Password/input-password".get_path()
	$"Password/input-password".focus_next = $"ConfirmPassword/input-confirm-password".get_path()
	$"ConfirmPassword/input-confirm-password".focus_next = $Language/OptionButton.get_path()
	$Language/OptionButton.focus_next = $"Username/input-name".get_path()
	
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
		"money": 50,
		"level": 1,
		"language": language,
		"sounds": true,
		"music": true,
	}
	
	database.insert_row("users", data)
	var user_added = database.select_rows("users", condition, ["id, username, password"])
	Global.user_id = user_added[0].id
	
	# CRIAÇÃO DO USUÁRIO NA DATATABLE TIPS
	var data_tips = {
		"id": user_added[0].id,
		"ai": 0,
		"tip": 1,
		"cards": 1
	}

	database.insert_row("tips", data_tips)
	
	# CRIAÇÃO DO USUÁRIO NA DATATABLE TIPS
	var data_challanges = {
		"id": user_added[0].id,
		"level": 1,
		"challange01": "not_completed",
		"challange02": "not_completed",
		"challange03": "not_completed",
		"challange04": "not_completed",
		"challange05": "not_completed",
	}

	database.insert_row("challanges", data_challanges)
	
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
