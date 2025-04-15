extends Node2D

class_name MoneyText

func Setup(amount):
	if amount > 0:
		$HBoxContainer/Sign.text = "+"
	else:
		$HBoxContainer/Sign.text = "-"
	$HBoxContainer/Label.text = str(int(abs(amount)))
	
func _process(delta: float) -> void:
	global_position.y -= 30 * delta
	
func _on_timer_timeout() -> void:
	queue_free()
