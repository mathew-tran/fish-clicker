extends Node

class_name GameManager



signal MoneyUpdate(amount)

signal BaitChanged(baitData)

var GameData = {
	
}

	
func _ready():
	GameData["Money"] = 0
	GameData["BaitInventory"] = {
		
	}
	
	await get_tree().process_frame
	AddMoney(0)
	BaitChanged.emit(load("res://Resources/Levels/Baits/BAIT_NONE.tres"))


	
func GetBait(baitName):
	if GameData["BaitInventory"].has(baitName):
		return GameData["BaitInventory"][baitName]
	return 0
	
func AddBait(baitName, amount = 1):
	if GameData["BaitInventory"].has(baitName):
		GameData["BaitInventory"][baitName] += amount
	else:
		GameData["BaitInventory"][baitName] = amount
		
func RemoveBait(baitName, amount = 1):
	if GameData["BaitInventory"].has(baitName):
			GameData["BaitInventory"][baitName] -= amount
			
func AddMoney(amount):
	if GameData.has("Money"):
		GameData["Money"] += amount
	MoneyUpdate.emit(GetMoney())

func RemoveMoney(amount):
	if GameData.has("Money"):
		GameData["Money"] -= amount
		
	MoneyUpdate.emit(GetMoney())
	
func GetMoney():
	return GameData["Money"]
				
func CanAfford(price):
	return price <= GetMoney()
	

	
