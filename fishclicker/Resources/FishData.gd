extends Resource

class_name FishData

enum SIZE {
	EXTRA_SMALL,
	SMALL,
	LARGE
}

enum CONDITION {
	POOR,
	AVERAGE,
	GREAT,
	EXCELLENT
}

enum RARITY {
	COMMON,
	RARE,
	LEGENDARY
}

@export var FishImage : Texture
@export var FishName = ""
@export var Rarity : RARITY
@export var FishSize : SIZE
@export var FishID = "A000"
@export var Tugs = 3
@export var TimeLimit = 5.0
@export var Cost = 0
var Condition : CONDITION

func DetermineCondition():
	var result = randi() % 100
	if result <= 80:
		Condition = CONDITION.POOR
	elif result <= 85:
		Condition = CONDITION.AVERAGE
	elif result <= 90:
		Condition = CONDITION.GREAT
	else:
		Condition = CONDITION.EXCELLENT
	
func SellFish():
	var amount = 0
	amount = Cost + randi() % 3
	
	match Condition:
		CONDITION.POOR:
			pass
		CONDITION.AVERAGE:
			amount *= 1.2
		CONDITION.GREAT:
			amount *= 1.8
		CONDITION.EXCELLENT:
			amount *= 2.0
			
	amount = round(amount)
	Finder.GetGameManager().AddFish(FishID)
	Finder.GetGameManager().AddMoney(amount)


func HasCaughtFish():
	return Finder.GetGameManager().HasCaughtFish(FishID)
