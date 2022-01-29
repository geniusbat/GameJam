extends ClearRoom

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Door.monitoring = false
	PlayerInfo.backgroundMusic.stream=preload("res://Assets/Audio/BGM/corpusculo.mp3")
	PlayerInfo.backgroundMusic.volume_db=-15
	PlayerInfo.backgroundMusic.play()
	pass # Replace with function body.
	
func RoomCleared():
	$Door.monitoring = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
