extends KinematicBody2D

enum PERSONALITIES {onda, corpusculo}
var personality = PERSONALITIES.corpusculo
var moveSpeed = 100

var inputDir := Vector2()
var direction : Vector2

enum STATES {normal, hurt}
var state = STATES.normal

onready var animationPlayer : AnimationPlayer = $AnimationPlayer

func _physics_process(_delta):
	inputDir = Vector2()
	if Input.is_action_pressed("move_down"):
		inputDir.y = 1
	elif Input.is_action_pressed("move_up"):
		inputDir.y = -1
	if Input.is_action_pressed("move_left"):
		inputDir.x = -1
	elif Input.is_action_pressed("move_right"):
		inputDir.x = 1
	var movement = move_and_slide(inputDir*moveSpeed)
	if inputDir != Vector2.ZERO:
		animationPlayer.play("Walk")
	else:
		animationPlayer.play("Idle")
