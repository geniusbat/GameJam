extends Control

var sequence = 0
var time = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerInfo.backgroundMusic.stream=preload("res://Assets/Audio/BGM/hablando_con_el_villano.mp3")
	PlayerInfo.backgroundMusic.volume_db=-25
	PlayerInfo.backgroundMusic.play()



func _process(delta):
	if Input.is_action_just_pressed("attack"):
		sequence += 1
		
	if sequence == 1:
		$Onda.visible = true
		$Corpusculo.visible = false
		$RichTextLabel.text = "Oscar… Por favor, detén todo esto."
	if sequence == 2:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "Nada va a detener esto. Ni yo, ni mucho menos tú."
	if sequence == 3:
		$Onda.visible = true
		$Corpusculo.visible = false
		$RichTextLabel.text = "Oscar, por favor. ¿Es este el mundo en el que quieres vivir?"
	if sequence == 4:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "Este es el mundo en el que siempre he vivido. Y si no eres capaz de verlo, entonces no tengo nada más que decirte."
	if sequence >= 5:
		time += delta
		$Onda.visible = false
		$Corpusculo.visible = false
		$Oscar.visible = false
		$RichTextLabel.visible = false
		if time >= 1:
			get_tree().change_scene_to(load("res://Levels/Enemy levels/Enemy level 12.tscn"))

