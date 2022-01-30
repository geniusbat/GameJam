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
	if sequence == 2:
		$Onda.visible = true
		$RichTextLabel.text = "La Luz fuerte."
	if sequence == 3:
		$Onda.visible = false
		$RichTextLabel.text = "La Luz inteligente."
	if sequence == 4:
		$Onda.visible = true
		$RichTextLabel.text = "Cada vez que me quedaba dormida ella aparecía."
	if sequence == 5:
		$Onda.visible = false
		$RichTextLabel.text = "Cada vez que me quedaba dormida ella aparecía."
	if sequence == 6:
		$Onda.visible = true
		$RichTextLabel.text = "Siempre metiéndome en líos."
	if sequence == 7:
		$Onda.visible = false
		$RichTextLabel.text = "Siempre aguándome la fiesta."
	if sequence == 8:
		$Onda.visible = true
		$RichTextLabel.text = "Era horrible."
	if sequence == 9:
		$Onda.visible = false
		$RichTextLabel.text = "Era horrible."
	if sequence == 10:
		$Onda.visible = false
		$RichTextLabel.text = "Pero..."
	if sequence == 11:
		$Onda.visible = true
		$RichTextLabel.text = "Todo cambió cuando apareció él."
	if sequence >= 12:
		time += delta
		$RichTextLabel.visible = false
		if time >= 1:
			get_tree().change_scene_to(load("res://Levels/Movable levels/Movable level 2.tscn"))
