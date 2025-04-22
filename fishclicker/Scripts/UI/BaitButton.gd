
extends Button

@export var OwnedBait : BaitData


func _ready() -> void:
	Setup()
	name = "BAITBUTTON-" + OwnedBait.BaitName
	
func Setup():
	$VBoxContainer/Image.texture = OwnedBait.BaitImage
	$VBoxContainer/Title.text = OwnedBait.BaitName
	Update()
	
	
func Update():
	var amount = int(Finder.GetGameManager().GetBait(OwnedBait.BaitName))
	
	disabled = HasBait() == false
	$CannotAfford.visible = disabled 
	
	if HasBait() == false:
		$CannotAfford/Label.text = "No Bait"

	if OwnedBait.bIsInfinite == false:
		$Owned.text = "(" + str(amount) + ")"
	else:
		$Owned.text = "(∞)" 
		
	
	
func _on_button_up() -> void:
	if HasBait():
		Finder.GetGameManager().ChangeBait(OwnedBait)
		Update()
		Finder.GetPlayerUI().UpdateUI(PlayerUI.STATE.DEFAULT)
		
func HasBait():
	if OwnedBait.bIsInfinite:
		return true
	return Finder.GetGameManager().GetBait(OwnedBait.BaitName) > 0
