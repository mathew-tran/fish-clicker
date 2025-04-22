extends Node

func GetGameManager() -> GameManager:
	return get_tree().get_nodes_in_group("GameManager")[0]

func GetPlayerUI() -> PlayerUI:
	return get_tree().get_nodes_in_group("PlayerUI")[0]

func GetEffectsGroup():
	return get_tree().get_nodes_in_group("Effects")[0]

func GetUnlockText() -> UnlockText:
	return get_tree().get_nodes_in_group("UnlockText")[0]

func GetFishingRod() -> FishingRod:
	return get_tree().get_nodes_in_group("FishingRod")[0]
	
func GetFilesFromDirectory(path):
	var dir = DirAccess.open(path)
	var files = []
	if dir:
		for file_name in dir.get_files():
			files.append(file_name)
	return files
