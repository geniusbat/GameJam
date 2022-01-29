extends Node

var health = 5

enum PERSONALITIES {onda, corpusculo}
var personality = PERSONALITIES.corpusculo

var healthGUI
var healthGUIRes = preload("res://Objects/Player/HealthGUI.tscn")

func _ready():
	healthGUI=healthGUIRes.instance()

func _process(_delta):
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

func Die():
	get_tree().quit()

func ChangePersonality():
	match(personality):
		PERSONALITIES.corpusculo:
			personality=PERSONALITIES.onda
		PERSONALITIES.onda:
			personality=PERSONALITIES.corpusculo
