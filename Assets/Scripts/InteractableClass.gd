extends Node2D

class_name Interactable
export(String)var description = "Generic text"
export(int,1,3)var requiresCharacter = 3 #1 is corpusculo, 2 is onda, 3 is both
export(String)var otherDescription = "Generic text 2"

var bodyIn = false
onready var interactArea : Area2D = $InteractArea
onready var descriptionGUIRes = preload("res://Objects/Player/DescriptionGUI.tscn")
var descriptionGUI : RichTextLabel

func _ready():
	var _a=interactArea.connect("body_entered",self,"BodyEntered")
	_a=interactArea.connect("body_exited",self,"BodyExited")
	interactArea.set_collision_mask_bit(0,false)
	interactArea.set_collision_mask_bit(1,true)
	descriptionGUI = descriptionGUIRes.instance()
	descriptionGUI.text = description
	MatchText()

func _input(event):
	if event.is_action_pressed("interact"):
		if bodyIn:
			Interact()

func _process(_delta):
	if bodyIn:
		descriptionGUI.rect_position=get_global_transform_with_canvas().origin-descriptionGUI.rect_size/2
		MatchText()

func MatchText():
	if RightPersonality():
		descriptionGUI.text=description
		descriptionGUI.rect_size=Vector2(182,descriptionGUI.get_content_height())
		descriptionGUI.visible=true
	else:
		if otherDescription=="":
			descriptionGUI.text=description
			descriptionGUI.rect_size=Vector2(182,descriptionGUI.get_content_height())
			descriptionGUI.visible=false
		else:
#			descriptionGUI.rect_size=Vector2(150,56)
			descriptionGUI.text=otherDescription
			descriptionGUI.rect_size=Vector2(182,descriptionGUI.get_content_height())
			descriptionGUI.visible=true

#Check if interacting with the character set with "requireCharacter"
func RightPersonality():
	match(requiresCharacter):
		1:
			if PlayerInfo.personality==PlayerInfo.PERSONALITIES.corpusculo:
				return true
			else:
				return false
		2:
			if PlayerInfo.personality==PlayerInfo.PERSONALITIES.corpusculo:
				return false
			else:
				return true
		3:
			return true

func Interact():
	print_debug("Interacted")

func BodyEntered(body):
	bodyIn = true
	DescriptionGuiLayer.add_child(descriptionGUI)

func BodyExited(_body):
	bodyIn = false
	DescriptionGuiLayer.remove_child(descriptionGUI)
