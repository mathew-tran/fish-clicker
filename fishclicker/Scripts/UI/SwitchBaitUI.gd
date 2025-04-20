extends Popup

var BaitDirectory = "res://Resources/Levels/Baits/"

func _on_about_to_popup() -> void:
	for child in $Panel/GridContainer.get_children():
		child.queue_free()
	
	var baits = Finder.GetFilesFromDirectory(BaitDirectory)
	for bait in baits:
		var fullPath = BaitDirectory + bait
		var baitData = load(fullPath) as BaitData
		if baitData.bIsInfinite or Finder.GetGameManager().GetBait(baitData.BaitName) > 0:
			var instance = load("res://Prefabs/UI/BaitButton.tscn").instantiate()
			instance.OwnedBait = baitData
			$Panel/GridContainer.add_child(instance)
