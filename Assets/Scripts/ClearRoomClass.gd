extends Node2D

class_name ClearRoom
func _process(delta):
	if get_tree().get_nodes_in_group("Enemies").size()==0:
		RoomCleared()

func RoomCleared():
	pass
