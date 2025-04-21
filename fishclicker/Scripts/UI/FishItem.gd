extends Control

var FishDataRef : FishData

func Update():
	if FishDataRef:
		Setup(FishDataRef)
		
func Setup(fishData : FishData):
	FishDataRef = fishData
	$Image.modulate = Color.BLACK
	$Image.texture = fishData.FishImage
	$Label.text = "???"
	
	
	var bHasCaught = fishData.HasCaughtFish()
	
	match fishData.Rarity:
		FishData.RARITY.COMMON:
			$Label.modulate = Color.WHITE
		FishData.RARITY.RARE:
			$Label.modulate = Color.PURPLE
		FishData.RARITY.LEGENDARY:
			$Label.modulate = Color.ORANGE
	if bHasCaught:
		$Image.modulate = Color.WHITE
		$Label.text = fishData.FishName
	
func IsCaught():
	return $Label.text != "???"
