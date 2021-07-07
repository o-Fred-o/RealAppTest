extends Control

#onready var todo_liste := $Background/MarginContainer/VBoxContainer/Item_List/Task_List
#onready var task := $Background/MarginContainer/VBoxContainer/Item_Add/Task_Description

func _ready():
    Events.connect("item_add_clicked", self, "_on_add_item_clicked")

func _on_add_item_clicked(task):
    Events.emit_signal("item_add_to_list", task)
