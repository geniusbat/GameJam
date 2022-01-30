extends Node2D

func _ready():
	if PlayerInfo.backgroundMusic.stream!=preload("res://Assets/Audio/BGM/corpusculo.mp3"):
		PlayerInfo.backgroundMusic.stream=preload("res://Assets/Audio/BGM/corpusculo.mp3")
		PlayerInfo.backgroundMusic.volume_db=-25
		PlayerInfo.backgroundMusic.play()
