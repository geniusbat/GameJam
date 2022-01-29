extends Control

func _ready():
	if PlayerInfo.backgroundMusic.stream!=preload("res://Assets/Audio/BGM/misteriosa.mp3"):
		PlayerInfo.backgroundMusic.stream=preload("res://Assets/Audio/BGM/misteriosa.mp3")
		PlayerInfo.backgroundMusic.play()
	


func _on_Button_pressed():
	var _a=get_tree().change_scene_to(preload("res://Levels/Menus/MainMenu.tscn"))
