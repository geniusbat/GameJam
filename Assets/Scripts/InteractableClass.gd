extends Node2D

class_name Interactable
export(String)var description = "Generic text"
export(int,1,3)var requiresCharacter = 3 #1 is corpusculo, 2 is onda, 3 is both
export(String)var corpusculoDescription = "Generic text"

var mouseIn = false
onready var interactArea : Area2D = $InteractArea
onready var descriptionGUIRes = preload("res://Objects/Player/DescriptionGUI.tscn")
var descriptionGUI : RichTextLabel

func _ready():
	var _a=interactArea.connect("mouse_entered",self,"MouseEntered")
	_a=interactArea.connect("mouse_exited",self,"MouseExited")
	descriptionGUI = descriptionGUIRes.instance()
	descriptionGUI.text = description

func _process(delta):
	if mouseIn:
		descriptionGUI.rect_position=get_global_transform_with_canvas().origin-descriptionGUI.rect_size/2


func Interact():
	pass

func MouseEntered():
	mouseIn = true
	DescriptionGuiLayer.add_child(descriptionGUI)

func MouseExited():
	mouseIn = false
	DescriptionGuiLayer.remove_child(descriptionGUI)
