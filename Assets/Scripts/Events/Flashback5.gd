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
		$RichTextLabel.text = "A todos nos pilló por sorpresa."
	if sequence == 2:
		$Onda.visible = true
		$RichTextLabel.text = "Si yo la tenía, ¿por qué no él? "
	if sequence == 3:
		$Onda.visible = false
		$RichTextLabel.text = "Mira que es casualidad que la tengamos dos hermanos."
	if sequence == 4:
		$Onda.visible = true
		$RichTextLabel.text = "La Dualidad."
	if sequence == 5:
		$Onda.visible = false
		$RichTextLabel.text = "La Dualidad."
	if sequence == 6:
		$Onda.visible = true
		$RichTextLabel.text = "Si lo hubiese previsto, podría haberlo evitado. "
		time += delta
	if sequence == 7:
		$Onda.visible = false
		$RichTextLabel.text = "Para cuando nos dimos cuenta, era tarde. "
	if sequence == 8:
		$Onda.visible = true
		$RichTextLabel.text = "Oscar estaba completamente alienado por su otro yo. "
	if sequence == 9:
		$Onda.visible = false
		$RichTextLabel.text = "El idiota de mi hermano tenía una personalidad super inteligente. "
	if sequence == 10:
		$Onda.visible = true
		$RichTextLabel.text = "Cuando creció parecía que había aprendido a controlarlo por sí solo."
	if sequence == 11:
		$Onda.visible = false
		$RichTextLabel.text = "Dijo que iba a buscar una cura."
	if sequence == 12:
		$Onda.visible = true
		$RichTextLabel.text = "Pero lo que encontró fue mucho más allá"
	if sequence == 13:
		$Onda.visible = false
		$RichTextLabel.text = "Aprendió a manipular la propia Dualidad."
	if sequence == 14:
		$Onda.visible = true
		$RichTextLabel.text = "En sí mismo."
	if sequence == 15:
		$Onda.visible = false
		$RichTextLabel.text = "Y en todos los demás. "
	if sequence >= 16:
		time += delta
		$RichTextLabel.visible = false
		if time >= 1:
			get_tree().change_scene_to(load("res://Levels/Enemy levels/Enemy level 11.tscn"))
