extends Popup


func _on_about_to_popup() -> void:
	for child in $Panel/GridContainer.get_children():
			child.Update()
