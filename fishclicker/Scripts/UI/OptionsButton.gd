extends Button

func _on_button_up() -> void:
	Finder.GetPlayerUI().UpdateUI(PlayerUI.STATE.OPTIONS)
