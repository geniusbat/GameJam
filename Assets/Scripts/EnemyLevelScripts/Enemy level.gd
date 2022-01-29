extends ClearRoom

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Door.monitoring = false
	pass # Replace with function body.
	
func RoomCleared():
	$Door.monitoring = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
