extends Control

func _ready() -> void:
	Finder.GetGameManager().XPGained.connect(OnXPGained)
	OnXPGained(0)
	
func OnXPGained(amount):
	$ProgressBar.value = Finder.GetGameManager().GetXP()
	$ProgressBar.max_value = Finder.GetGameManager().MaxXP
	$ProgressBar/Label.text = "" + str(int(Finder.GetGameManager().GetLevel()))
	$AnimationPlayer.stop()
	$AnimationPlayer.play("anim")
