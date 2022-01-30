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
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "!? Te dije que no vinieras."
	if sequence == 2:
		$CorpusculoImagen.visible = false
		$OndaImagen.visible = true
		$Onda.visible = true
		$Corpusculo.visible = false
		$RichTextLabel.text = "Tienes que parar esto, el mundo se ha vuelto loco, no soportan La Dualidad."
	if sequence == 3:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "Si no son capaces de soportar lo que hemos sufrido, no merecen mi misericordia."
	if sequence == 4:
		$Onda.visible = true
		$RichTextLabel.text = "¿Y qué hay de buscar una cura? ¿No fue eso por lo que hiciste todo esto?"
	if sequence == 5:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "La cura vendrá cuando los capaces se impongan."
	if sequence >= 6:
		time += delta
		$RichTextLabel.visible = false
		if time >= 1:
			get_tree().change_scene_to(load("res://Levels/Enemy levels/Enemy level 10.tscn"))
