extends ClearRoom

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hasPlayed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerInfo.stream!=preload("res://Assets/Audio/BGM/corpusculo.mp3"):
		PlayerInfo.backgroundMusic.stream=preload("res://Assets/Audio/BGM/corpusculo.mp3")
		PlayerInfo.backgroundMusic.volume_db=-25
		PlayerInfo.backgroundMusic.play()
	$Door.monitoring = false
	pass # Replace with function body.
	
func RoomCleared():
	$Door.monitoring = true
	if (!$AudioStreamPlayer.playing and !hasPlayed):
		$AudioStreamPlayer.play()
		hasPlayed = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
