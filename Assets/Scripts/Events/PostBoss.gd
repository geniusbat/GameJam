extends Control

var sequence = 0
var time = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerInfo.backgroundMusic.stream=preload("res://Assets/Audio/BGM/triste_final.mp3")
	PlayerInfo.backgroundMusic.volume_db=-25
	PlayerInfo.backgroundMusic.play()



func _process(delta):
	if Input.is_action_just_pressed("attack") and sequence != 12:
		sequence += 1
		
	if sequence == 1:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "No..."
	if sequence == 2:
		$Onda.visible = true
		$Corpusculo.visible = false
		$RichTextLabel.text = "Vamos, acaba con esto."
	if sequence == 3:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "No..."
	if sequence == 4:
		$Onda.visible = true
		$Corpusculo.visible = false
		$RichTextLabel.text = "Por favor, es..."
	if sequence == 5:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "No hay forma de pararlo."
	if sequence == 6:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "!? ¿Cómo?"
	if sequence == 7:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "Lo diseñé así. Aunque quisiera no hay vuelta atrás."
	if sequence == 8:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "Entonces encuéntrala."
	if sequence == 9:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "¿Es que vas a obligarme?"
	if sequence == 10:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "Sí, si hace falta."
	if sequence == 11:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "Lamento decepcionarte, entonces."
	if sequence == 12:
		time += delta
		$Onda.visible = false
		$Corpusculo.visible = false
		$Oscar.visible = false
		$RichTextLabel.visible = false
		$End.modulate = Color($End.modulate.r - 0.1,$End.modulate.g - 0.1,$End.modulate.b - 0.1)
		if time >= 1:
			sequence += 1
	if sequence == 13:
		$Onda.visible = true
		$RichTextLabel.text = "¿Oscar? ¡OSCAR!"
		$RichTextLabel.visible = true
		time = 0
	if sequence >= 14:
		time += delta
		$Onda.visible = false
		$Corpusculo.visible = false
		$Oscar.visible = false
		$RichTextLabel.visible = false
		if time >= 1:
			get_tree().change_scene_to(load("res://Levels/Menus/MainMenu.tscn"))

