extends Control

func _ready():
	#Adeptus mechanicus moment, leave this here bc it works
	$StopSignLayer/TextureRect.rect_size=Vector2(480,270)
	$BackgroundLayer/TextureRect.rect_size=Vector2(509,286)


func _process(_delta):
	var x = (get_global_mouse_position().x - (get_viewport_rect().size.x/2)) / (get_viewport_rect().size.x/2)
	var y = (get_global_mouse_position().y - (get_viewport_rect().size.y/2)) / (get_viewport_rect().size.y/2)
	$BackgroundLayer.offset=Vector2(x*3,y*3)
	$StopSignLayer.offset=Vector2(x*7,y*7)

func GoButtonPressed():
	$AnimationPlayer.play("GoAnim")

func ExitButtonPressed():
	get_tree().quit()

func Go():
	var _a = get_tree().change_scene_to(preload("res://Levels/Test.tscn"))
