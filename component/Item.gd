extends HBoxContainer

export var is_editable : bool = false
export var description : String = ""

onready var task := $Task_Description
onready var add_button := $Add_Button
onready var remove_button := $Remove_Button

func _ready():
    task.text=description
    if is_editable:
        remove_button.visible=false
    if !is_editable:
        add_button.visible=false

func _on_Add_Button_pressed():
    Events.emit_signal("item_add_clicked", task.text)
    task.text=""


func _on_Remove_Button_pressed():
    Events.emit_signal("item_remove_clicked", task.text)