extends ClearRoom

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hasPlayed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Door.monitoring = false
	PlayerInfo.backgroundMusic.stream=preload("res://Assets/Audio/BGM/corpusculo.mp3")
<<<<<<< HEAD
	PlayerInfo.backgroundMusic.volume_db=-100
=======
	PlayerInfo.backgroundMusic.volume_db=-25
>>>>>>> 463b759690d3291d914170f827f3454665b05411
	PlayerInfo.backgroundMusic.play()
	pass # Replace with function body.
	
func RoomCleared():
	$Door.monitoring = true
	if (!$AudioStreamPlayer.playing and !hasPlayed):
		$AudioStreamPlayer.play()
		hasPlayed = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
