@tool

extends Button

@export var BaitToSell : BaitData

@export var FishingLevel : int


func _ready() -> void:
	name = "BAIT-" + BaitToSell.BaitName
	Setup()
	
func Setup():
	$VBoxContainer/HBoxContainer/Amount.text = str(BaitToSell.Cost)
	$VBoxContainer/Image.texture = BaitToSell.BaitImage
	$VBoxContainer/Title.text = BaitToSell.BaitName
	Update()
	
	
func Update():
	var amount = Finder.GetGameManager().GetBait(BaitToSell.BaitName)
	$Owned.text = "(" + str(amount) + ")"
	disabled = CanAfford() == false or Finder.GetGameManager().GetLevel() < FishingLevel

	if Finder.GetGameManager().GetLevel() < FishingLevel:
		$CannotAfford/Label.text = "Unlock on Fishing Level: " + str(FishingLevel) 
	elif CanAfford() == false:
		$CannotAfford/Label.text = "Cannot afford"
	$CannotAfford.visible = disabled
	
func _on_button_up() -> void:
	if CanAfford():
		Finder.GetGameManager().AddBait(BaitToSell.BaitName, 1)
		Finder.GetGameManager().RemoveMoney(BaitToSell.Cost)
		Update()
		
func CanAfford():
	return Finder.GetGameManager().CanAfford(BaitToSell.Cost)
