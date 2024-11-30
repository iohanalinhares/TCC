extends HTTPRequest

var api_url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent"
var api_key = "AIzaSyBgv2t-pgQyxwrhOqGObCgqCuuy_CVPzYs"
var http_request
var target_node

func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_on_HTTPRequest_request_completed"))


func make_gemini_request(text, target_node):
	self.target_node = target_node
	
	var request_url = api_url + "?key=" + api_key
	var headers = ["Content-Type: application/json"]

	var data = {
		"contents": [
			{
				"parts": [
					{
						"text": text
					}
				]
			}
		]
	}
	
	var json_data = JSON.stringify(data, "\t")
	
	var error = http_request.request(
		request_url,
		headers,
		HTTPClient.METHOD_POST,
		json_data
	)

	if error != OK:
		print("Erro ao fazer a requisição:", error)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.new()
		var parse_result = json.parse(body.get_string_from_utf8())
		
		if parse_result == OK:
			var resposta = json.get_data()
			var texto_resposta = resposta["candidates"][0]["content"]["parts"][0]["text"]
			texto_resposta = texto_resposta.replace("**", "")
			print("Resposta da IA:", texto_resposta)
			
			if target_node and target_node.has_method("set_text"):
				target_node.text = texto_resposta
		else:
			print("Erro ao analisar JSON. Código de erro:", parse_result)
	else:
		print("Erro na requisição:", response_code)
