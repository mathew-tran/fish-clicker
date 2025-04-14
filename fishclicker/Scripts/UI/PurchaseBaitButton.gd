@tool

extends Button

@export var BaitToSell : BaitData

func _ready() -> void:
	Setup()
	name = "BAIT-" + BaitToSell.BaitName
	
func Setup():
	$VBoxContainer/HBoxContainer/Amount.text = str(BaitToSell.Cost)
	$VBoxContainer/Image.texture = BaitToSell.BaitImage
	$VBoxContainer/Title.text = BaitToSell.BaitName
	Update()
	
	
func Update():
	var amount = Finder.GetGameManager().GetBait(BaitToSell.BaitName)
	$Owned.text = "(" + str(amount) + ")"
	disabled = CanAfford() == false
	$CannotAfford.visible = disabled
	
func _on_button_up() -> void:
	if CanAfford():
		Finder.GetGameManager().AddBait(BaitToSell.BaitName, 1)
		Finder.GetGameManager().RemoveMoney(BaitToSell.Cost)
		Update()
		
func CanAfford():
	return Finder.GetGameManager().CanAfford(BaitToSell.Cost)
