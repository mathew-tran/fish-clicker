extends Popup


@onready var FishItemContainer = $Panel/ScrollContainer/GridContainer
@onready var CompleteText = $Panel/CompletePercentage
var BaitPath = "res://Resources/Levels/Baits/"
func _ready() -> void:
	for child in FishItemContainer.get_children():
		child.queue_free()
	var baits = Finder.GetFilesFromDirectory(BaitPath)
	
	for bait in baits:
		var fullPath = BaitPath + bait
		var fishPool = load(fullPath).GetAllFish()
		for fish in fishPool:
			var instance = load("res://Prefabs/UI/FishItem.tscn").instantiate()
			instance.FishDataRef = fish
			FishItemContainer.add_child(instance)
			
func _on_about_to_popup() -> void:
	var total = 0
	var caught = 0
	for child in FishItemContainer.get_children():
		child.Update()
		total +=1
		if child.IsCaught():
			caught += 1
	var completePercent = (float(caught) / float(total)) * 100.0
	CompleteText.text = str(snappedf(completePercent, .01)) + "%"
	
func _on_close_button_button_up() -> void:
	visible = false
