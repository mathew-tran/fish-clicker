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
	var pool = CommonPool
	if result <= 80:
		pool = CommonPool
	elif result <= 97:
		if len(RarePool) > 0:
			pool = RarePool
	else:
		if len(LegendaryPool) > 0:
			pool = LegendaryPool
	pool = pool.duplicate(true)
	pool.shuffle()
	return pool[0]
	
func HasCompletedBait():
	return Finder.GetGameManager().HasCompletedChallenge(BaitID)

func CompleteBait():
	return Finder.GetGameManager().AddCompletedChallenge(BaitID)

func GetAllFish():
	var fishPool = []
	for fish in CommonPool:
		fishPool.append(fish)
	for fish in RarePool:
		fishPool.append(fish)
	for fish in LegendaryPool:
		fishPool.append(fish)
	return fishPool
