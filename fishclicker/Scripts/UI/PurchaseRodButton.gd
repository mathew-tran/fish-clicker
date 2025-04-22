@tool

extends Button

@export var RodToSell : RodData

@export var FishingLevel : int


func _ready() -> void:
	Setup()
	
func Setup():
	$VBoxContainer/HBoxContainer/Amount.text = str(RodToSell.Cost)
	$VBoxContainer/Image.texture = RodToSell.RodTexture
	$VBoxContainer/Title.text = RodToSell.RodName
	Update()
	
	
func Update():
	var bOwned = OwnsRod()
	if bOwned:
		$Owned.text = "owned"
		$CannotAfford.visible = false
		$VBoxContainer/HBoxContainer.visible = false
	else:
		$Owned.text = ""
		$CannotAfford.visible = CanBuy() == false
		$VBoxContainer/HBoxContainer.visible = true
		if Finder.GetGameManager().GetLevel() < FishingLevel:
			$CannotAfford/Label.text = "Unlock on Fishing Level: " + str(FishingLevel) 
		if CanBuy() == false:
			$CannotAfford/Label.text = "Cannot Afford"
	

		
	
	
func _on_button_up() -> void:
	if CanBuy() and OwnsRod() == false:
		Finder.GetGameManager().AddRod(RodToSell.RodID)
		Finder.GetGameManager().RemoveMoney(RodToSell.Cost)
		Update()
		Finder.GetGameManager().AddXP(30)
	
	if OwnsRod():
		get_tree().get_nodes_in_group("FishingRod")[0].Equip(RodToSell)
		
func OwnsRod():
	return Finder.GetGameManager().HasRod(RodToSell.RodID)
	
func CanBuy():
	return Finder.GetGameManager().CanAfford(RodToSell.Cost) 
