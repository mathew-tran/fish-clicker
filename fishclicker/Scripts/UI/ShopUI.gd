extends Popup


func _on_about_to_popup() -> void:
	for child in $Panel/TabContainer/Bait/Container.get_children():
			child.Update()
	for child in $Panel/TabContainer/Rods/Container.get_children():
			child.Update()
