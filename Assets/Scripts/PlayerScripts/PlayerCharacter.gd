
extends KinematicBody2D

var health = 5

enum PERSONALITIES {onda, corpusculo}
var personality = PERSONALITIES.corpusculo
var changeTimer = 0.2 #0.2

var hurtTimer = 0.3 #0.3

var moveSpeed = 100
var inputDir := Vector2()
var direction : Vector2

enum STATES {normal, hurt, attacking}
var state = STATES.normal

onready var animationPlayer : AnimationPlayer = $AnimationPlayer
onready var attackNode = $Attack
onready var attackArea = $Attack/AttackArea/CollisionShape2D
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
				attackNode.attacking=true
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
			var _movement = move_and_slide(inputDir*moveSpeed)
			if inputDir != Vector2.ZERO:
				animationPlayer.play("Walk")
			else:
				animationPlayer.play("Idle")
			AssignCorrectDirection(inputDir)
		STATES.attacking:
			pass
		STATES.hurt:
			hurtTimer-=delta
			var _movement = move_and_slide(direction*moveSpeed)
			if hurtTimer<0:
				state=STATES.normal
	PushBoxes()

func PushBoxes():
	var num = get_slide_count()
	for i in range(num):
		var obj = get_slide_collision(i).collider
		if obj!=null and obj.is_in_group("Pushables"):
			var dir = (obj.position-position).normalized()
			dir.x = round(dir.x)
			dir.y = round(dir.y)
			obj.move_and_slide(dir*moveSpeed/2)
		

func ChangePersonality():
	changeTimer=0.6
	var ins = changeParticles.instance()
	add_child(ins)
	PlayerInfo.ChangePersonality()
	match(personality):
		PERSONALITIES.corpusculo:
			personality=PERSONALITIES.onda
		PERSONALITIES.onda:
			personality=PERSONALITIES.corpusculo

func Hurt(dam:int,sourcePoint:Vector2):
	health-=dam
	state=STATES.hurt
	direction = (position-sourcePoint).normalized()
	hurtTimer=0.3

func FinishedAttacking():
	state=STATES.normal
	attackArea.disabled=true
	attackNode.attacking=false
	attackNode.visible=false
	attackNode.previouslyAttacked.clear()

#Assign correct scales depending of input direction
func AssignCorrectDirection(dir:Vector2):
	if dir.x < 0:
		set_global_transform(Transform2D(Vector2(-1,0),Vector2(0,1),Vector2(position.x,position.y)))
	elif dir.x > 0:
		 set_global_transform(Transform2D(Vector2(1,0),Vector2(0,1),Vector2(position.x,position.y)))
