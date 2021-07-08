extends Control

func _ready():
    var config = ConfigFile.new()
    var err = config.load("res://settings.cfg")
    if err == OK: # If not, something went wrong with the file loading
        # Look for the display/width pair, and default to 1024 if missing
        Global.BASE_URL = config.get_value("Meteo", "url")
        #encoded key :-)
        Global.API_KEY  = Marshalls.base64_to_utf8(config.get_value("Meteo", "key"))
