extends Resource

class_name RodData

@export var RodName = ""
@export var RodTexture : Texture
@export var RodID = "000"
@export var Cost = 0

func OwnsRod():
	return Finder.GetGameManager().HasRod(RodID) or Cost == 0
