extends Resource

class_name FishData

enum SIZE {
	SMALL,
	LARGE
}

@export var FishImage : Texture
@export var FishName = ""
@export var FishSize : SIZE
@export var FishID = "A000"
@export var Tugs = 3
@export var TimeLimit = 5.0
