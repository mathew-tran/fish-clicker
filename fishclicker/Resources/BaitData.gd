extends Resource

class_name BaitData

@export var BaitName = ""
@export var BaitImage : Texture
@export var BaitID = "000"
@export var Cost = 0
@export var CommonPool : Array[FishData]
@export var RarePool : Array[FishData]
@export var LegendaryPool : Array[FishData]
@export var bIsInfinite = false

func GetRandomFish() -> FishData:
	var result = randi() % 100
	if result <= 70:
		CommonPool.shuffle()	
		return CommonPool[0]
	if result <= 95:
		RarePool.shuffle()
		return RarePool[0]
	LegendaryPool.shuffle()
	return LegendaryPool[0]
	
func HasCompletedBait():
	return Finder.GetGameManager().HasCompletedChallenge(BaitID)

func CompleteBait():
	return Finder.GetGameManager().AddCompletedChallenge(BaitID)
