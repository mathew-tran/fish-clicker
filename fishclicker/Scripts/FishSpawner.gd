extends Node

class_name FishSpawner

@export var CommonPool : Array[FishData]
@export var RarePool : Array[FishData]
@export var LegendaryPool : Array[FishData]
func _ready():
	DetermineTime()
	
func DetermineTime():
	$Timer.wait_time = randf_range(2, 4)
	$Timer.start()
	print("Spawning Fish")

func _on_timer_timeout():
	SpawnFish()

func SpawnFish():
	var Spawns = get_tree().get_nodes_in_group("SpawnMarker")
	Spawns.shuffle()
	var newSpawn = Spawns[0].global_position
	var fishInstance = load("res://Prefabs/Fish.tscn").instantiate() as Fish
	fishInstance.Setup(GetRandomFish())
	fishInstance.global_position = newSpawn
	add_child(fishInstance)
	fishInstance.Dead.connect(OnFishDead)
	fishInstance.Caught.connect(OnFishCaught)

func GetRandomFish() -> FishData:
	var result = randi() % 100
	if result <= 70:
		CommonPool.shuffle()	
		return CommonPool[0]
	if result <= 95:
		RarePool.shuffle()
		return RarePool[0]
	LegendaryPool.shuffle()
	return LegendaryPool[0]
	
func OnFishDead():
	DetermineTime()
	
func OnFishCaught():
	DetermineTime()
