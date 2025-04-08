extends AnimatedSprite2D


func Play():
	play("default")
	visible = true

func _on_animation_finished():
	stop()
	visible = false
