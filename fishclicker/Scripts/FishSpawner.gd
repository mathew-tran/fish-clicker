extends Node

class_name FishSpawner



signal FishBite
func _ready():
	DetermineTime()

	
func DetermineTime():
	$Timer.wait_time = randf_range(2, 12)
	$Timer.start()
	print("Spawning Fish")

func _on_timer_timeout():
	SpawnFish()

func SpawnFish():
	
	if Finder.GetGameManager().CanUseCurrentBait() == false:
		$Timer.start()
		return
		
	var Spawns = get_tree().get_nodes_in_group("SpawnMarker")
	Spawns.shuffle()
	

	var newSpawn = Spawns[0].global_position
	var fishInstance = load("res://Prefabs/Fish.tscn").instantiate() as Fish
	fishInstance.global_position = newSpawn
	
	var result = randi() % 100
	if result <= 10:
		var garbage = load("res://Resources/Levels/Baits/001_BAIT_GARBAGE.tres").GetRandomFish()
		fishInstance.Setup(garbage)
	else:
		fishInstance.Setup(Finder.GetGameManager().CurrentBait.GetRandomFish())
	add_child(fishInstance)
	fishInstance.Dead.connect(OnFishDead)
	fishInstance.Caught.connect(OnFishCaught)
	Finder.GetGameManager().UseCurrentBait()

	
func OnFishDead():
	DetermineTime()
	
func OnFishCaught():
	DetermineTime()
