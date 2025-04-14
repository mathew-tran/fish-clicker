extends Node

func GetGameManager():
	return get_tree().get_nodes_in_group("GameManager")[0]

func GetPlayerUI():
	return get_tree().get_nodes_in_group("PlayerUI")[0]
