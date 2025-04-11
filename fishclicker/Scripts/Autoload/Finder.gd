extends Node

func GetGameManager():
	return get_tree().get_nodes_in_group("GameManager")[0]
