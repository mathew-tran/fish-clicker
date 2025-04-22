extends Node2D

class_name Fish

enum STATE {
	WAITING,
	FIGHTING,
	COMPLETE
}

var CurrentState = STATE.WAITING
var ClickAmount = 0
# Called when the node enters the scene tree for the first time.

signal Dead
signal Caught

var FishDataReference : FishData

func _enter_tree():
	scale = Vector2.ZERO
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, .3)

func Setup(fishData : FishData):
	ClickAmount = fishData.Tugs + randi_range(0, 3)
	$RunAwayTimer.wait_time = fishData.TimeLimit + randf_range(1, 5)
	$DetailedFish.texture = fishData.FishImage
	FishDataReference = fishData
	FishDataReference.DetermineCondition()
	var starsToShow = FishDataReference.Condition + 1
	print(starsToShow)
	$DetailedFish/Rarity.visible = false
	for x in range(0, $DetailedFish/Rarity.get_child_count()):
		$DetailedFish/Rarity.get_child(x).visible = x < starsToShow
		$DetailedFish/Rarity.get_child(x).visible = x < starsToShow
		
	match fishData.FishSize:
		FishData.SIZE.EXTRA_SMALL:
			$FishSprite.texture = load("res://Art/Sprites/Fish/ExtraSmall.png")
		FishData.SIZE.SMALL:
			$FishSprite.texture = load("res://Art/Sprites/Fish/Small.png")
		FishData.SIZE.LARGE:
			$FishSprite.texture = load("res://Art/Sprites/Fish/Medium.png")

func _on_area_2d_button_up():
	match CurrentState:
		STATE.WAITING:
			CurrentState = STATE.FIGHTING
			get_tree().get_nodes_in_group("FishingRod")[0].AttachToFish(self)
			$Activity.visible = false
			$SplashAnim.visible = true
			$SplashAnim.Play()
			$FishSprite/AnimationPlayer.play("anim")
			$RunAwayTimer.start()
		STATE.FIGHTING:
			$SplashAnim.Play()
			ClickAmount -= 1
			if ClickAmount <= 0:
				CurrentState = STATE.COMPLETE
				$FishSprite/AnimationPlayer.stop()
				$SplashAnim.stop()
				$DetailedFish.scale = Vector2.ZERO
				$DetailedFish.visible = true
				var fishTween = get_tree().create_tween()
				fishTween.tween_property($DetailedFish, "scale", Vector2.ONE, .1)
				await fishTween.finished

				
				$SplashAnim.visible = false
				$FishSprite.visible = false
				$RunAwayTimer.stop()
				$CompleteTimer.start()
				var tween = get_tree().create_tween()
				tween.tween_property(self, "global_position", get_tree().get_nodes_in_group("FishingRod")[0].GetSittingArea(), randf_range(.3, .8))
				Caught.emit()
				

func _on_run_away_timer_timeout():
	Dead.emit()
	queue_free()
	
func GetFishSprite():
	return $FishSprite



func _on_complete_timer_timeout():
	$DetailedFish/Rarity.visible = true
	FishDataReference.SellFish()
	await get_tree().create_timer(.3).timeout
	$FishSprite/AnimationPlayer.stop()
	
	$FishSprite/AnimationPlayer.play("dance")


func _on_animation_player_animation_finished(anim_name):
	$FishSprite/AnimationPlayer.speed_scale = randf_range(1, 3.5)
	if anim_name == "dance":
		queue_free()
	pass # Replace with function body.
