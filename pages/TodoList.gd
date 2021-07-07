extends Control

# centralise les signaux
# item -> todolist -> list

func _ready():
    Events.connect("item_add_clicked", self, "_on_add_item_clicked")
    Events.connect("item_remove_clicked", self, "_on_remove_item_clicked")

func _on_add_item_clicked(task):
    if !task.empty():
        Events.emit_signal("item_add_to_list", task)
        
func _on_remove_item_clicked(id):
    Events.emit_signal("item_remove_from_list", id)
