extends HBoxContainer

func _on_Save_Button_pressed():
    Events.emit_signal("list_save")
