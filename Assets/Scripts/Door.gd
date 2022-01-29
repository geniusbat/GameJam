extends ChangeSceneTrigger

var changeTimer = 0.2 #0.2
var inside = false

func _ready():
	$DoorClosed.visible=true
	$DoorOpened.visible=false
	var _a=connect("body_entered",self,"_on_MoveToSceneTrigger_body_entered")

func _process(delta):
	if inside:
		changeTimer-=delta
		if changeTimer<=0:
			var _a=get_tree().change_scene_to(goTo)

func _on_MoveToSceneTrigger_body_entered(_body):
	inside=true
	$DoorClosed.visible=false
	$DoorOpened.visible=true
