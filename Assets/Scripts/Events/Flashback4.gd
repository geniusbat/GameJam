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
		$Onda.visible = false
		$RichTextLabel.text = "¿Corpúsculo?"
	if sequence == 2:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "¡Claro! Os llamáis Luz, y he visto en la tele a un señor decir que la luz se comporta como onda y corpúsculo."
	if sequence == 3:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "¿Y eso qué significa?"
	if sequence == 4:
		$Onda.visible = true
		$RichTextLabel.text = "Significa que los fotones se comportan en algunos experimentos como una onda y en otros como una partícula."
	if sequence == 5:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "Empollona."
	if sequence == 6:
		$Onda.visible = true
		$RichTextLabel.text = "No sé cómo no se me había ocurrido antes, vaya imaginación, Chris."
		time += delta
	if sequence == 7:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "El móvil."
	if sequence == 8:
		$Onda.visible = true
		$Corpusculo.visible = false
		$RichTextLabel.text = "··· ¿Diga? Hola papá ··· ¿Cómo? Vamos… voy para allá."
	if sequence == 9:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "¿Que ha pasado?"
	if sequence == 10:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "Es mi hermano, le pasa algo raro."
		time = 0
	if sequence >= 11:
		time += delta
		$RichTextLabel.visible = false
		if time >= 1:
			get_tree().change_scene_to(load("res://Levels/Event levels/EncounterOscar.tscn"))

