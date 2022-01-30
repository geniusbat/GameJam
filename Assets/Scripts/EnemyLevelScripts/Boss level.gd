extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerInfo.backgroundMusic.stream!=preload("res://Assets/Audio/BGM/super_boss_ultimate (1).mp3"):
		PlayerInfo.backgroundMusic.stream=preload("res://Assets/Audio/BGM/super_boss_ultimate (1).mp3")
		PlayerInfo.backgroundMusic.volume_db=-30
		PlayerInfo.backgroundMusic.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
