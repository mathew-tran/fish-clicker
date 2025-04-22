extends Button


func _on_button_up() -> void:
	Finder.GetGameManager().ClearData()
