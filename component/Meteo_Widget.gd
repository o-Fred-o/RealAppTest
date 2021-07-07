extends VBoxContainer

const BASE_URL := "http://api.openweathermap.org/data/2.5"
const API_KEY := "e9419816e84fe4341310b5df20291125"

var http_request : HTTPRequest

onready var query := $City_Input/Query
onready var city_name := $VBoxContainer/City_name
onready var weather_description := $VBoxContainer/Weather_description
onready var feels_like = $VBoxContainer/Feels_like

func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")

func _http_request_completed(result, response_code, headers, body):
	print(body)
	var response = parse_json(body.get_string_from_utf8())
	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		push_error("Couldn't load the image.")
		
	#result.text=parse_json(response)
	city_name.text = response.name + " " + response.sys.country
	weather_description.text = response.weather[0].description
	feels_like.text = String(response.main.feels_like)
	
	# http://openweathermap.org/img/w/${response.data.weather[0].icon}.png
	#print(response.name)
	#print(response.sys.country)
	#print(response.main.feels_like)
	#print(response.main.temp_min)
	#print(response.main.temp_max)


func _on_Check_pressed():
	#/weather?q=${this.query}&units=metric&&appid=${API_KEY}
	var weather_request= "%s/weather?q=%s&units=metric&appid=%s"
	var full_request = weather_request % [BASE_URL,query.text,API_KEY]
	
	var error = http_request.request(full_request)
	#print(full_request)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
