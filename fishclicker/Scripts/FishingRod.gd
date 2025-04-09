extends Sprite2D

var FishRef = null


func AttachToFish(fishToAttachTo : Fish):
	FishRef = fishToAttachTo.GetFishSprite()
	fishToAttachTo.Caught.connect(OnCaught)
	
	$AnimationPlayer.play("anim")
	
func OnCaught():
	$AnimationPlayer.stop()
	
func _physics_process(delta):
	if is_instance_valid(FishRef):
		$Line2D.points[1] = $Line2D.to_local(FishRef.global_position)
	else:
		$Line2D.points[1] = $Line2D.points[0]
		$AnimationPlayer.stop()

func GetSittingArea():
	return $"Fishing Area".global_position
