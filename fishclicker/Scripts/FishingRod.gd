extends Sprite2D

var FishRef = null


func AttachToFish(fishToAttachTo):
	FishRef = fishToAttachTo
	$AnimationPlayer.play("anim")
	
func _physics_process(delta):
	if is_instance_valid(FishRef):
		$Line2D.points[1] = $Line2D.to_local(FishRef.global_position)
	else:
		$Line2D.points[1] = $Line2D.points[0]
		$AnimationPlayer.stop()
