extends KinematicBody2D

var stage := 0
onready var animationPlayer : AnimationPlayer = $AnimationPlayer
onready var projectile = preload("res://Objects/Enemies/EnemyProjectile.tscn")

enum STATES {normal, hurt, teleport, attacking,transforming}
var state = STATES.normal

var attackTimer = 1.8 #1.8
var hurtTimer = 0.4 #TODO

onready var player = get_tree().get_root().find_node("PlayerCharacter",true,false)

func _ready():
	$Particles2D.visible=true
	$Humo.visible=true
	$Particles2D.emitting=false
	$Humo.emitting=false
	position=get_parent().get_node("Stage00").position
	for el in get_parent().get_node("Stage00").get_children():
		el.monitoring=false
	get_parent().get_node("Stage00").visible=false
	for el in get_parent().get_node("Stage01").get_children():
		el.monitoring=false
	get_parent().get_node("Stage01").visible=false
	for el in get_parent().get_node("Stage02").get_children():
		el.monitoring=false
	get_parent().get_node("Stage02").visible=false


func _physics_process(delta):
	if attackTimer>0:
		attackTimer-=delta
	match(state):
		STATES.normal:
			if attackTimer<=0:
				attackTimer=1.8
				state=STATES.attacking
				animationPlayer.play("Attack")
		STATES.hurt:
			hurtTimer-=delta
			#Add max stage limit
			if hurtTimer<=0:
				animationPlayer.play("Teleport")
		STATES.teleport:
			pass
		STATES.attacking:
			pass

func Hurt(_dam,_sourcePoint):
	if state==STATES.attacking or state==STATES.normal:
		state=STATES.hurt
		animationPlayer.play("Hurt")
		hurtTimer=0.4

func Shoot():
	var ins = projectile.instance()
	get_parent().add_child(ins)
	ins.position=position
	ins.direction=(player.position-position).normalized()

func Teleport():
	#Move to new poss
	match(stage):
		0:
			stage+=1
			position=get_parent().get_node("Stage01").position
			for el in get_parent().get_node("Stage00").get_children():
				el.monitoring=true
			get_parent().get_node("Stage00").visible=true
		1:
			stage+=1
			position=get_parent().get_node("Stage02").position
			for el in get_parent().get_node("Stage01").get_children():
				el.monitoring=true
			get_parent().get_node("Stage01").visible=true
		2:
			stage+=1
			position=get_parent().get_node("Stage03").position
			for el in get_parent().get_node("Stage02").get_children():
				el.monitoring=true
			get_parent().get_node("Stage02").visible=true
		3:
			ToBossB()

func DoneTeleport():
	state=STATES.normal
	attackTimer=0.5

func FinishedAttacking():
	state=STATES.normal
	animationPlayer.play("Idle")
	attackTimer=randf()+0.6

func ToBossB():
	state=STATES.transforming
	animationPlayer.play("Transform")
	set_collision_layer_bit(4,false)

func Change():
	var ins = preload("res://Objects/Enemies/Boss/BossB.tscn").instance()
	get_parent().add_child(ins)
	ins.position=position
	queue_free()
	
