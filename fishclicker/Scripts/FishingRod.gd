extends Sprite2D

class_name FishingRod

var FishRef = null
var RodRef : RodData	
	
func Equip(rodData : RodData):
	texture = rodData.RodTexture
	RodRef = rodData
	
func _ready() -> void:
	Equip(load("res://Resources/Levels/Rods/R001_Rod_Basic.tres"))
	Finder.GetGameManager().BaitChanged.connect(OnBaitChanged)
	Finder.GetGameManager().BaitAdded.connect(OnBaitAdded)
	$AnimationPlayer2.play("baitanim")
	
func OnBaitChanged(baitData : BaitData):
	if Finder.GetGameManager().CanUseCurrentBait():
		$Bait.visible = true
	if baitData.bIsInfinite == false or baitData.BaitName != "None":
		$Bait.texture = baitData.BaitImage
		if Finder.GetGameManager().CanUseCurrentBait() == false:
			$Bait.texture = null
	else:
		$Bait.texture = null

func OnBaitAdded(baitName):
	if Finder.GetGameManager().CanUseCurrentBait():
		$Bait.visible = true
	
func AttachToFish(fishToAttachTo : Fish):
	FishRef = fishToAttachTo.GetFishSprite()
	fishToAttachTo.Caught.connect(OnCaught)

	
	$AnimationPlayer.play("anim")
	
func OnCaught():
	$AnimationPlayer.stop()
	
func _physics_process(delta):
	if is_instance_valid(FishRef):
		$Line2D.points[1] = $Line2D.to_local(FishRef.global_position)
		$Bait.visible = false
	else:
		$Line2D.points[1] = $Line2D.points[0]
		$AnimationPlayer.stop()
		$Bait.visible = true

func GetSittingArea():
	return $"Fishing Area".global_position
