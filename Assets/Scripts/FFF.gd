
extends KinematicBody2D

enum PERSONALITIES {onda, corpusculo}
var personality = PERSONALITIES.corpusculo
var changeTimer = 0.2

var moveSpeed = 100
var inputDir := Vector2()
var direction : Vector2

enum STATES {normal, hurt, attacking}
var state = STATES.normal

onready var animationPlayer : AnimationPlayer = $AnimationPlayer
onready var attackNode = $Attack
onready var attackArea = $CollisionShape2D
onready var changeParticles = preload("res://Objects/Player/ChangeParticles.tscn")

func _ready():
	attackArea.disabled=true
	attackNode.visible=false

func _unhandled_input(event):
	if event.is_action_pressed("change"):
		if state==STATES.normal and changeTimer<0:
			ChangePersonality()
	elif event.is_action_pressed("attack"):
		if personality==PERSONALITIES.corpusculo:
			if state==STATES.normal:
				state=STATES.attacking
				attackArea.disabled=false
				attackNode.visible=true
				attackNode.look_at(get_global_mouse_position())
				animationPlayer.play("Attack")

func _physics_process(delta):
	if changeTimer>0:
		changeTimer-=delta
	match(state):
		STATES.normal:
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
		STATES.attacking:
			pass
		STATES.hurt:
			var movement = move_and_slide(direction*moveSpeed)
	PushBoxes()

func PushBoxes():
	var num = get_slide_count()
	print(num)
	for i in range(num):
		print("f")
		var col = get_slide_collision(i)
		print(col.collider)
		if "Box" in col.collider.get_name():
			col.collider.move_and_slide((col.collider.position-position).normalize()*6)
		

func ChangePersonality():
	changeTimer=0.6
	var ins = changeParticles.instance()
	add_child(ins)
	match(personality):
		PERSONALITIES.corpusculo:
			personality=PERSONALITIES.onda
		PERSONALITIES.onda:
			personality=PERSONALITIES.corpusculo

func FinishedAttacking():
	state=STATES.normal
	attackArea.disabled=true
	attackNode.visible=false
