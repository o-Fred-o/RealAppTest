class_name UserDict extends Object

var structure : Dictionary = Dictionary()
var data : Dictionary = Dictionary()

func _init():
    structure["id"] = {"data_type":"int", "primary_key": true, "not_null": true}
    structure["name"] = {"data_type":"text", "not_null": true}
    structure["age"] = {"data_type":"int", "not_null": true}
    structure["address"] = {"data_type":"char(50)"}
    structure["salary"] = {"data_type":"real"}

# pour test
func add_data():
    data["id"] = 1
    data["name"] = "nom"
    data["age"] = 30
    data["address"] = "Test adresse "
    data["salary"] = 1500
