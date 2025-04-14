extends CanvasLayer

class_name PlayerUI

enum STATE {
	DEFAULT,
	SHOP,
	BAIT
}
var MainUIs = [
]

func _ready() -> void:
	MainUIs = [
		$ShopUI,
		$SwitchBaitUI
	]
	
	Finder.GetGameManager().BaitChanged.connect(OnBaitChanged)

func OnBaitChanged(bait):
	UpdateUI(STATE.DEFAULT)
	
func UpdateUI(state : STATE):
	CloseUI()
	match state:
		STATE.DEFAULT:
			pass
		STATE.SHOP:
			$ShopUI.popup_centered()
		STATE.BAIT:
			$SwitchBaitUI.popup_centered()

func CloseUI():
	for ui in MainUIs:
		ui.visible = false
			
