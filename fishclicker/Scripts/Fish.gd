extends Node2D


enum STATE {
	WAITING,
	FIGHTING,
}

var CurrentState = STATE.WAITING
var ClickAmount = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	ClickAmount = randi_range(3, 20)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_button_up():
	match CurrentState:
		STATE.WAITING:
			CurrentState = STATE.FIGHTING
			get_tree().get_nodes_in_group("FishingRod")[0].AttachToFish($FishSprite)
			$Activity.visible = false
			$SplashAnim.visible = true
			$SplashAnim.Play()
			$FishSprite/AnimationPlayer.play("anim")
		STATE.FIGHTING:
			$SplashAnim.Play()
			ClickAmount -= 1
			if ClickAmount <= 0:
				queue_free()
	pass # Replace with function body.
