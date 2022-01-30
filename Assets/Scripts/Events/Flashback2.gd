extends Control

var sequence = 0
var time = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

func _ready():
	PlayerInfo.backgroundMusic.stream=preload("res://Assets/Audio/BGM/melancolica.mp3")
	PlayerInfo.backgroundMusic.volume_db=-25
	PlayerInfo.backgroundMusic.play()



func _process(delta):
	if Input.is_action_just_pressed("attack"):
		sequence += 1
		
	if sequence == 1:
		$Onda.visible = true
		$RichTextLabel.text = "No te acerques peque, dentro de mí vive un monstruo."
	if sequence == 2:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "No me dan miedo los monstruos."
	if sequence == 3:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "No te dan miedo, ¿eh?"
	if sequence == 4:
		$RichTextLabel.text = " · · · Vaya. ¿De verdad no te doy miedo, mocoso?"
	if sequence == 5:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "No, ¿tú eres el monstruo?"
	if sequence == 6:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "No soy un monstruo, soy Luz. Eso te lo habrá dicho la otra."
	if sequence == 7:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "¿La otra?"
	if sequence == 8:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "La otra Luz, con la que estabas hablando antes."
	if sequence == 9:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "¡Oh! No parece que os llevéis muy bien."
	if sequence == 10:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "No, es una aguafiestas."
	if sequence >= 11:
		time += delta
		$RichTextLabel.visible = false
		if time >= 1:
			get_tree().change_scene_to(load("res://Levels/Movable levels/Movable level 3.tscn"))
