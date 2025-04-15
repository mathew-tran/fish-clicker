extends HBoxContainer


func _ready():
	Finder.GetGameManager().MoneyUpdate.connect(OnMoneyUpdate)
	
func OnMoneyUpdate(amount):
	$Label.text = str(amount)
	$AnimationPlayer.play("anim")
