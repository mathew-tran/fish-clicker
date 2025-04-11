extends Node

class_name GameManager

var Money = 0

signal MoneyUpdate(amount)

func _ready():
	await get_tree().process_frame
	AddMoney(0)

func AddMoney(amount):
	Money += amount
	MoneyUpdate.emit(Money)
	
