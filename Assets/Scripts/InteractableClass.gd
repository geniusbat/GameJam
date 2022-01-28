extends Node2D

class_name Interactable
export(String)var description = "Generic text"
export(int,1,3)var requiresCharacter = 3 #1 is corpusculo, 2 is onda, 3 is both
export(String)var otherDescription = "Generic text 2"

var mouseIn = false
onready var interactArea : Area2D = $InteractArea
onready var descriptionGUIRes = preload("res://Objects/Player/DescriptionGUI.tscn")
var descriptionGUI : RichTextLabel

func _ready():
	var _a=interactArea.connect("mouse_entered",self,"MouseEntered")
	_a=interactArea.connect("mouse_exited",self,"MouseExited")
	descriptionGUI = descriptionGUIRes.instance()
	descriptionGUI.text = description
	match(requiresCharacter):
		1:
			if PlayerInfo.personality==PlayerInfo.PERSONALITIES.corpusculo:
				descriptionGUI.text=description
			else:
				descriptionGUI.text=otherDescription
		2:
			if PlayerInfo.personality==PlayerInfo.PERSONALITIES.corpusculo:
				descriptionGUI.text=otherDescription
			else:
				descriptionGUI.text=description
		3:
			descriptionGUI.text=description

func _process(delta):
	if mouseIn:
		descriptionGUI.rect_position=get_global_transform_with_canvas().origin-descriptionGUI.rect_size/2
		match(requiresCharacter):
			1:
				if PlayerInfo.personality==PlayerInfo.PERSONALITIES.corpusculo:
					descriptionGUI.text=description
				else:
					descriptionGUI.text=otherDescription
			2:
				if PlayerInfo.personality==PlayerInfo.PERSONALITIES.corpusculo:
					descriptionGUI.text=otherDescription
				else:
					descriptionGUI.text=description
			3:
				descriptionGUI.text=description


func Interact():
	pass

func MouseEntered():
	mouseIn = true
	DescriptionGuiLayer.add_child(descriptionGUI)

func MouseExited():
	mouseIn = false
	DescriptionGuiLayer.remove_child(descriptionGUI)
