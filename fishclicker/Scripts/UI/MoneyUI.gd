extends HBoxContainer

var TargetAmount = 0
var CurrentAmount = -1
func _ready():
	Finder.GetGameManager().MoneyUpdate.connect(OnMoneyUpdate)
	Finder.GetGameManager().MoneyChanged.connect(OnMoneyChanged)
	ForceUpdate()
func ForceUpdate():
	var amount = Finder.GetGameManager().GetMoney()
	TargetAmount = amount
	CurrentAmount = amount - 1
func OnMoneyUpdate(amount):
	$AnimationPlayer.stop()
	TargetAmount = amount
	
	
	$AnimationPlayer.play("anim")

func OnMoneyChanged(amount):
	if amount == 0:
		return
		
	var instance = load("res://Prefabs/UI/MoneyText.tscn").instantiate()
	instance.global_position = $SpawnTextPos.global_position
	instance.Setup(amount)
	Finder.GetEffectsGroup().add_child(instance)

func _on_timer_timeout() -> void:
	if TargetAmount != CurrentAmount:
		var diff = 1
		if abs(TargetAmount - CurrentAmount) > 50:
			diff = 5
		if abs(TargetAmount - CurrentAmount) > 100:
			diff = 10
		
		if abs(TargetAmount - CurrentAmount) > 200:
			diff = 40
		
		if abs(TargetAmount - CurrentAmount) > 300:
			diff = 80
		if TargetAmount > CurrentAmount:
			CurrentAmount += diff
		elif TargetAmount < CurrentAmount:
			CurrentAmount -= diff
		$Label.text = str(int(CurrentAmount))
