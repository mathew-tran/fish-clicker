extends Node

class_name FishSpawner

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
	fishInstance.Setup(load("res://Resources/Levels/Pond/P001_GoldFish.tres"))
	fishInstance.global_position = newSpawn
	add_child(fishInstance)
	fishInstance.Dead.connect(OnFishDead)
	fishInstance.Caught.connect(OnFishCaught)

func OnFishDead():
	DetermineTime()
	
func OnFishCaught():
	DetermineTime()
