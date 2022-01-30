extends KinematicBody2D

var stage := 0
onready var animationPlayer : AnimationPlayer = $AnimationPlayer
onready var projectile = preload("res://Objects/Enemies/EnemyProjectile.tscn")

enum STATES {normal, hurt, teleport, attacking}
var state = STATES.normal

var attackTimer = 1.8 #1.8
var hurtTimer = 0.4 #TODO

onready var player = get_tree().get_root().find_node("PlayerCharacter",true,false)

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

func Hurt(dam,sourcePoint):
	if !state==STATES.teleport:
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
			pass
		1:
			pass
		2:
			pass
		3:
			pass

func DoneTeleport():
	state=STATES.normal
	attackTimer=0.5

func FinishedAttacking():
	state=STATES.normal
	animationPlayer.play("Idle")
	attackTimer=randf()+0.6
