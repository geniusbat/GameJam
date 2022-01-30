extends Node

var health = 10

enum PERSONALITIES {onda, corpusculo}
var personality = PERSONALITIES.onda

var lastLevel : String = ""

var healthGUI
var healthGUIRes = preload("res://Objects/Player/HealthGUI.tscn")
onready var backgroundMusic = AudioStreamPlayer.new()

func _ready():
	add_child(backgroundMusic)
	backgroundMusic.stream=preload("res://Assets/Audio/BGM/misteriosa.mp3")
	backgroundMusic.volume_db=-10
#	backgroundMusic.play()
	healthGUI=healthGUIRes.instance()

func Go():
	if lastLevel!="":
		var _a=get_tree().change_scene_to(load(lastLevel))
	else:
		var _a=get_tree().change_scene_to(preload("res://Levels/Movable levels/Movable level 1.tscn"))

func _process(_delta):
	CheckHealth()
	if get_tree().get_root().find_node("PlayerCharacter",true,false)!=null:
		if !healthGUI.is_inside_tree():
			add_child(healthGUI)
		else:
			if health==0:
				Die()
				return
			var container = healthGUI.get_node("GUI/HealthContainer")
			if container.get_child_count()!=health:
				var diff = health-container.get_child_count()
				if diff < 0:
					container.remove_child(container.get_child(0))
					diff+=1
				elif diff > 0:
					var ins = TextureRect.new()
					ins.texture = preload("res://Assets/Sprites/Heart.png")
					container.add_child(ins)
					diff-=1
	else:
		if healthGUI.is_inside_tree():
			remove_child(healthGUI)
	if backgroundMusic.stream==preload("res://Assets/Audio/BGM/corpusculo.mp3"):
		backgroundMusic.volume_db=-25
	else:
		backgroundMusic.volume_db=-10


func CheckHealth():
	if health > 10:
		health = 10

func Die():
	var _a=get_tree().change_scene_to(preload("res://Levels/Menus/GameOver.tscn"))

func ChangePersonality():
	match(personality):
		PERSONALITIES.corpusculo:
			personality=PERSONALITIES.onda
		PERSONALITIES.onda:
			personality=PERSONALITIES.corpusculo
