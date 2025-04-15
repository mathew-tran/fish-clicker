extends Panel

@onready var FishItemContainer = $ScrollContainer/Container
var FishItemClass = load("res://Prefabs/UI/FishItem.tscn")

func _ready() -> void:
	Finder.GetGameManager().MoneyUpdate.connect(OnMoneyChanged)
	Finder.GetGameManager().BaitChanged.connect(OnBaitChanged)
	
func OnBaitChanged(bait):
	Setup(bait)
	
func OnMoneyChanged(money):
	Setup(Finder.GetGameManager().CurrentBait)
	
func Setup(fishBait : BaitData):
	if fishBait == null:
		return
	
	for child in FishItemContainer.get_children():
		child.queue_free()
		
	for fish in fishBait.CommonPool:
		var instance = FishItemClass.instantiate()
		instance.Setup(fish)
		FishItemContainer.add_child(instance)

	for fish in fishBait.RarePool:
		var instance = FishItemClass.instantiate()
		instance.Setup(fish)
		FishItemContainer.add_child(instance)
	
	for fish in fishBait.LegendaryPool:
		var instance = FishItemClass.instantiate()
		instance.Setup(fish)
		FishItemContainer.add_child(instance)

	var missedFish = 0
	for fish in FishItemContainer.get_children():
		if fish.FishDataRef == null or fish.FishDataRef.HasCaughtFish() == false:
			missedFish += 1
			break
	if missedFish == 0:
		if fishBait.HasCompletedBait() == false:
			fishBait.CompleteBait()
			Finder.GetGameManager().AddMoney(500)
			
