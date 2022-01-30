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
	if Input.is_action_just_pressed("attack") and sequence != 6:
		sequence += 1
		
	if sequence == 1:
		$Onda.visible = true
		$RichTextLabel.text = "No, ¿para qué?"
	if sequence == 2:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "Bueno, vivís en el mismo cuerpo, tendríais que llevaros bien."
	if sequence == 3:
		$Onda.visible = true
		$RichTextLabel.text = "No me haría caso, es una bruta."
	if sequence == 4:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "Pero si no lo has intentado, venga, prueba a ver."
	if sequence == 5:
		$Onda.visible = true
		$RichTextLabel.text = "··· Esta bien."
	if sequence == 6:
		$Onda.visible = true
		$RichTextLabel.text = ""
		time += delta
	if time >= 1 and sequence == 6:
		sequence += 1
	if sequence == 7:
		$RichTextLabel.text = "¿Estás ahí?"
	if sequence == 8:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "¿Quien? ¿Eres… la otra Luz?"
	if sequence == 9:
		$Onda.visible = true
		$Corpusculo.visible = false
		$RichTextLabel.text = "La otra serás tú…"
	if sequence == 10:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "¡Luz!"
	if sequence == 11:
		$Onda.visible = true
		$RichTextLabel.text = "··· Sí, soy la otra Luz."
	if sequence == 12:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "¿Y qué quieres, otra Luz?"
	if sequence == 13:
		$Onda.visible = true
		$RichTextLabel.text = "He estado hablando con Chris. Creo que tiene razón en que deberíamos dejar de hacernos la vida imposible."
	if sequence == 14:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "No entiendo a qué te refieres."
	if sequence == 15:
		$Onda.visible = true
		$RichTextLabel.text = "Tu dejas de meternos en problemas, y yo me abro a tus “juegos”."
	if sequence == 16:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "··· Te escucho."
	if sequence == 17:
		$Onda.visible = true
		$RichTextLabel.text = "Y tenemos que dejar de solaparnos, ambas debemos recordar lo que hace la otra."
	if sequence == 18:
		$Onda.visible = false
		$Corpusculo.visible = true
		$RichTextLabel.text = "¿Y eso cómo lo hacemos?"
	if sequence == 19:
		$Onda.visible = false
		$Corpusculo.visible = false
		$RichTextLabel.text = "Yo puedo ayudar en eso."
		time = 0
	if sequence >= 20:
		time += delta
		$RichTextLabel.visible = false
		if time >= 1:
			get_tree().change_scene_to(load("res://Levels/Enemy levels/Enemy level 8.tscn"))
