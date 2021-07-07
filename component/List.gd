extends VBoxContainer

const TASK_ITEM := preload("res://component/Item.tscn")

onready var list := $ScrollContainer/ItemContainer

func _ready():
    Events.connect("item_add_to_list", self, "_on_add_item_to_list")


func _on_add_item_to_list(task):
    var task_item = TASK_ITEM.instance()
    task_item.description=task
    list.add_child(task_item)
