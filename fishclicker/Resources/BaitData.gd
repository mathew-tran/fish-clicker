extends Resource

class_name BaitData

@export var CommonPool : Array[FishData]
@export var RarePool : Array[FishData]
@export var LegendaryPool : Array[FishData]

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
	
