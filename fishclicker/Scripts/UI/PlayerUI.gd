extends CanvasLayer

class_name PlayerUI

enum STATE {
	DEFAULT,
	SHOP
}
var MainUIs = [
]

func _ready() -> void:
	MainUIs = [
		$ShopUI
	]


func UpdateUI(state : STATE):
	CloseUI()
	match state:
		STATE.DEFAULT:
			pass
		STATE.SHOP:
			$ShopUI.popup_centered()

func CloseUI():
	for ui in MainUIs:
		ui.visible = false
			
