extends Area2D

class_name ChangeSceneTrigger
export(String) var goTo = ("res://Levels/Movable level 1.tscn")
func _on_MoveToSceneTrigger_body_entered(_body):
	var _a=get_tree().change_scene_to(load(goTo))
