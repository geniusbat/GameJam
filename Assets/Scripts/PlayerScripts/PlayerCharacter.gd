
extends KinematicBody2D

enum PERSONALITIES {onda, corpusculo}
var personality = PERSONALITIES.onda
var changeTimer = 0.3 #0.3

var hurtTimer = 0.3 #0.3
var dashTimer = 0.2 #0.2
var dashCooldown = 0.2 #0.2

var moveSpeed = 100
var inputDir := Vector2()
var direction : Vector2

enum STATES {normal, hurt, attacking, dashing}
var state = STATES.normal

onready var animationPlayer : AnimationPlayer = $AnimationPlayerCorpusculo
onready var attackNode = $Attack
onready var attackArea = $Attack/AttackArea/CollisionShape2D
onready var changeParticles = preload("res://Objects/Player/ChangeParticles.tscn")

func _ready():
	attackArea.disabled=true
	attackNode.visible=false
	if PlayerInfo.personality==PlayerInfo.PERSONALITIES.corpusculo:
		PlayerInfo.personality=PlayerInfo.PERSONALITIES.onda
		personality=PERSONALITIES.onda
		ChangePersonality()
	else:
		personality=PERSONALITIES.corpusculo
		PlayerInfo.personality=PlayerInfo.PERSONALITIES.corpusculo
		ChangePersonality()

func _unhandled_input(event):
	if event.is_action_pressed("change"):
		if state==STATES.normal and changeTimer<0:
			ChangePersonality()
	elif event.is_action_pressed("attack"):
		if personality==PERSONALITIES.corpusculo:
			if state==STATES.normal:
				state=STATES.attacking
				animationPlayer.play("Attack")
	elif event.is_action_pressed("dash"):
		if state==STATES.normal and inputDir != Vector2.ZERO and dashCooldown <= 0:
			dashTimer = 0.3
			dashCooldown = 0.6
			state = STATES.dashing
			direction=inputDir

func _physics_process(delta):
	if changeTimer>0:
		changeTimer-=delta
	if dashCooldown>0:
		dashCooldown-=delta
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
			if personality==PERSONALITIES.corpusculo:
				var _movement = move_and_slide(inputDir*moveSpeed)
			else:
				var _movement = move_and_slide(inputDir*moveSpeed*1.2)
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
		STATES.dashing:
			dashTimer-=delta
			var collision = move_and_collide(direction*moveSpeed*3*delta)
			if dashTimer<0 or collision!=null:
				state=STATES.normal
	PushBoxes()

func PushBoxes():
	if personality==PERSONALITIES.corpusculo:
		var num = get_slide_count()
		for i in range(num):
			var obj = get_slide_collision(i).collider
			if obj!=null and obj.is_in_group("Pushables"):
				var dir = (obj.position-position).normalized()
				dir = Vector2(sign(dir.x)*int(abs(dir.x)>abs(dir.y)),sign(dir.y)*int(abs(dir.y)>abs(dir.x)))
	#			dir.x = round(dir.x)
	#			dir.y = round(dir.y)
				obj.move_and_slide(dir*moveSpeed/3)

func ChangePersonality():
	changeTimer=0.3
	var ins = changeParticles.instance()
	add_child(ins)
	PlayerInfo.ChangePersonality()
	match(personality):
		PERSONALITIES.corpusculo:
			personality=PERSONALITIES.onda
		PERSONALITIES.onda:
			personality=PERSONALITIES.corpusculo
	#Set correct image sprites based on personality
	animationPlayer.stop()
	match(personality):
		PERSONALITIES.corpusculo:
			animationPlayer=$AnimationPlayerCorpusculo
		PERSONALITIES.onda:
			animationPlayer=$AnimationPlayerOnda
	animationPlayer.play("Idle")

func Hurt(dam:int,sourcePoint:Vector2):
	PlayerInfo.health-=dam
	state=STATES.hurt
	direction = (position-sourcePoint).normalized()
	hurtTimer=0.3
	animationPlayer.play("Hurt")

func FinishedAttacking():
	state=STATES.normal
	attackNode.previouslyAttacked.clear()

#Assign correct scales depending of input direction
func AssignCorrectDirection(dir:Vector2):
	if dir.x < 0:
		set_global_transform(Transform2D(Vector2(-1,0),Vector2(0,1),Vector2(position.x,position.y)))
	elif dir.x > 0:
		 set_global_transform(Transform2D(Vector2(1,0),Vector2(0,1),Vector2(position.x,position.y)))
