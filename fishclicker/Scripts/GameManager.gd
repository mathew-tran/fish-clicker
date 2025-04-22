extends Node

class_name GameManager



signal MoneyUpdate(amount)
signal MoneyChanged(amount)

signal BaitChanged(baitData)
signal BaitAdded(baitName)

signal XPGained

var DefaultBait = load("res://Resources/Levels/Baits/000_BAIT_NONE.tres")
var CurrentBait : BaitData

var SaveFile = "user://savegame.save"

var GameData = {
	
}

var MaxXP = 100
var Scaling = 1.1
var ResidualAmount = 0

var XPTimer : Timer
	
func _ready():
	
	XPTimer = Timer.new()
	add_child(XPTimer)
	XPTimer.autostart = true
	XPTimer.wait_time = .04
	
	XPTimer.timeout.connect(OnXPTimerTimeout)
	XPTimer.start()
	GameData = LoadData()


	
	await get_tree().process_frame
	AddMoney(0)
	XPGained.emit(0)
	ChangeBait(DefaultBait)
	
func SaveData():
	var file = FileAccess.open(SaveFile, FileAccess.WRITE)
	file.store_string(JSON.stringify(GameData))
	file.close()

func LoadData():
	if FileAccess.file_exists(SaveFile):
		var file = FileAccess.open(SaveFile, FileAccess.READ)
		var result = JSON.parse_string(file.get_as_text())
		file.close()
		if result != null:
			return result
			
	var data = {}
	data["Money"] = 0
	data["BaitInventory"] = {
		
	}
	data["FishCaught"] = {
		
	}
	data["BaitCompleted"] = {
		
	}
	data["Rank"] = {
		"XP" : 0,
		"Level" : 0
	}
	return data
	
func ClearData():
	if FileAccess.file_exists(SaveFile):
		DirAccess.remove_absolute(SaveFile)
	get_tree().reload_current_scene()
	
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
	
	BaitAdded.emit(baitName)
	
func AddCompletedChallenge(baitID):
	GameData["BaitCompleted"][baitID] = 1
	
func HasCompletedChallenge(baitID):
	return GameData["BaitCompleted"].has(baitID)
	
func AddFish(fishData : FishData):
	if GameData["FishCaught"].has(fishData.FishID):
		GameData["FishCaught"][fishData.FishID] += 1
	else:
		GameData["FishCaught"][fishData.FishID] = 1
		var textToSay = "Found: " + fishData.FishName
		Finder.GetUnlockText().AddText(textToSay, 1.0)
		AddXP(30)
		

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
		BaitChanged.emit(CurrentBait)
	
func CanUseCurrentBait():
	if CurrentBait.bIsInfinite:
		return true
	return GetBait(CurrentBait.BaitName) > 0
	
func AddXP(amount):
	ResidualAmount += amount
	
	
func OnXPTimerTimeout():
	if ResidualAmount <= 0:
		return
		
	var rate = 1
	if ResidualAmount >= 20:
		rate = 5
	if ResidualAmount >= 40:
		rate = 10
	if ResidualAmount > 100:
		rate = 20
		
	if ResidualAmount > 200:
		rate = 80
		
	if ResidualAmount > 400:
		rate = 90
		
	GameData["Rank"]["XP"]	+= rate
	ResidualAmount -= rate
	if GetXP() >= MaxXP:
		GameData["Rank"]["XP"] = 0
		GameData["Rank"]["Level"] += 1
	XPGained.emit(rate)
	
	if ResidualAmount == 0:
		SaveData()
		print("save")
	
func GetXP():
	return GameData["Rank"]["XP"]
	
func GetLevel():
	return GameData["Rank"]["Level"]
	
func AddMoney(amount):
	MoneyChanged.emit(amount)
	if GameData.has("Money"):
		GameData["Money"] += int(amount)
	MoneyUpdate.emit(GetMoney())
	AddXP(amount)

func RemoveMoney(amount):
	MoneyChanged.emit(-amount)
	if GameData.has("Money"):
		GameData["Money"] -= amount
		
	MoneyUpdate.emit(GetMoney())
	
func GetMoney():
	return GameData["Money"]
				
func CanAfford(price):
	return price <= GetMoney()
	

	
