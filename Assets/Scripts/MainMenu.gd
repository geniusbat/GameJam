extends Control

func _process(_delta):
	var x = (get_global_mouse_position().x - (get_viewport_rect().size.x/2)) / (get_viewport_rect().size.x/2)
	var y = (get_global_mouse_position().y - (get_viewport_rect().size.y/2)) / (get_viewport_rect().size.y/2)
	$BackgroundLayer.offset=Vector2(x*3,y*3)
	$StopSignLayer.offset=Vector2(x*7,y*7)

func GoButtonPressed():
	$AnimationPlayer.play("GoAnim")

func ExitButtonPressed():
	get_tree().quit()
