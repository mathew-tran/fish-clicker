extends Button

var BaitRef : BaitData

func _ready() -> void:
	Finder.GetGameManager().BaitChanged.connect(OnBaitChanged)
	
func OnBaitChanged(baitData):
	Setup(baitData)
	$AnimationPlayer.play("anim")
	
func Setup(bait : BaitData):
	BaitRef = bait
	$Container/Title.text = bait.BaitName
	$Container/Image.texture = bait.BaitImage
	$Container/Owned.modulate = Color.WHITE
	if bait.bIsInfinite == false:
		var amount = Finder.GetGameManager().GetBait(bait.BaitName)
		$Container/Owned.text = "(" + str(amount) + ")"
		if amount == 0:
			$Container/Owned.modulate = Color.RED
	else:
		$Container/Owned.text = "(∞)" 


func _on_button_up() -> void:
	Finder.GetPlayerUI().UpdateUI(PlayerUI.STATE.BAIT)
