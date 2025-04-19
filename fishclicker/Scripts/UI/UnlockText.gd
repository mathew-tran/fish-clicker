extends Label

class_name UnlockText

var WordsToSay = []

func _enter_tree() -> void:
	text = ""
	
func _ready() -> void:
	$AnimationPlayer.play("anim")
	
func AddText(newText, time = .5):
	WordsToSay.append({
		"text" : newText,
		"duration" : time
	})
	SayNextLine()
	
func SayNextLine():
	if WordsToSay.size() > 0:
		text = WordsToSay[0]["text"]
		$WaitTimer.wait_time = WordsToSay[0]["duration"] + 1.0
		$WaitTimer.start()
		WordsToSay.pop_front()
		$AnimationPlayer.play_backwards("anim")
	

func _on_wait_timer_timeout() -> void:
	if WordsToSay.size() > 0:
		SayNextLine()
	else:
		$AnimationPlayer.play("anim")
