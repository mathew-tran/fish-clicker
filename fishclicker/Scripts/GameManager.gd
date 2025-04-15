extends Node

class_name GameManager



signal MoneyUpdate(amount)
signal MoneyChanged(amount)

signal BaitChanged(baitData)

var DefaultBait = load("res://Resources/Levels/Baits/BAIT_NONE.tres")
var CurrentBait : BaitData

var GameData = {
	
}

	
func _ready():
	
	GameData["Money"] = 0
	GameData["BaitInventory"] = {
		
	}
	GameData["FishCaught"] = {
		
	}
	GameData["BaitCompleted"] = {
		
	}
	
	await get_tree().process_frame
	AddMoney(0)
	ChangeBait(DefaultBait)

func ChangeBait(baitData):
	CurrentBait = baitData
	BaitChanged.emit(baitData)
	
func GetBait(baitName):
	if GameData["BaitInventory"].has(baitName):
		return GameData["BaitInventory"][baitName]
	return 0
	
func AddBait(baitName, amount = 1):
	if GameData["BaitInventory"].has(baitName):
		GameData["BaitInventory"][baitName] += amount
	else:
		GameData["BaitInventory"][baitName] = amount

func AddCompletedChallenge(baitID):
	GameData["BaitCompleted"][baitID] = 1
	
func HasCompletedChallenge(baitID):
	return GameData["BaitCompleted"].has(baitID)
	
func AddFish(fishID):
	if GameData["FishCaught"].has(fishID):
		GameData["FishCaught"][fishID] += 1
	else:
		GameData["FishCaught"][fishID] = 1

func HasCaughtFish(fishID):
	return GameData["FishCaught"].has(fishID)
	
func RemoveBait(baitName, amount = 1):
	if GameData["BaitInventory"].has(baitName):
			GameData["BaitInventory"][baitName] -= amount

func UseCurrentBait():
	if CurrentBait.bIsInfinite:
		return
	else:
		RemoveBait(CurrentBait.BaitName, 1)
		if GetBait(CurrentBait.BaitName) <= 0:
			ChangeBait(DefaultBait)
		ChangeBait(CurrentBait)
		
func AddMoney(amount):
	MoneyChanged.emit(amount)
	if GameData.has("Money"):
		GameData["Money"] += int(amount)
	MoneyUpdate.emit(GetMoney())

func RemoveMoney(amount):
	MoneyChanged.emit(-amount)
	if GameData.has("Money"):
		GameData["Money"] -= amount
		
	MoneyUpdate.emit(GetMoney())
	
func GetMoney():
	return GameData["Money"]
				
func CanAfford(price):
	return price <= GetMoney()
	

	
