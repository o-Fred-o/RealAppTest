extends HBoxContainer

export var is_editable : bool = false
export var description : String = ""

onready var task_description := $Task_Description
onready var add_button := $Add_Button
onready var remove_button := $Remove_Button

var myTask : TaskModel

func _ready():
    task_description.text=description
    if is_editable:
        remove_button.visible=false
    if !is_editable:
        add_button.visible=false
        task_description.editable=false

func _on_Add_Button_pressed():
    myTask = TaskModel.new(get_instance_id(),task_description.text)
    Events.emit_signal("task_add", myTask)
    task_description.text=""


func _on_Remove_Button_pressed():
    Events.emit_signal("task_remove", myTask)
