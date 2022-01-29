extends KinematicBody2D

var health = 2
var moveSpeed = 40
var direction : Vector2

enum STATES {idle, followPlayer, attack, hurt}
var state = STATES.idle

var attackTimer = 1.5 #1.5
var hurtTimer = 0.5 #0.5

onready var player : KinematicBody2D = get_tree().get_root().find_node("PlayerCharacter",true,false)
onready var animationPlayer : AnimationPlayer = $AnimationPlayer
onready var detectPlayer = $DetectPlayer
onready var seePlayer = $SeePlayer
onready var projectile = preload("res://Objects/Enemies/EnemyProjectile.tscn")

func _physics_process(delta):
	if attackTimer>=0:
		attackTimer-=delta
	match(state):
		STATES.idle:
			pass
		STATES.followPlayer:
			var dir = (player.position-position).normalized()
			var _a=move_and_slide(dir*moveSpeed)
			AssignCorrectDirection(dir)
		STATES.attack:
			var dir = (player.position-position).normalized()
			AssignCorrectDirection(dir)
		STATES.hurt:
			var _a=move_and_slide(direction*50)
			hurtTimer-=delta
			if hurtTimer<=0:
				state=STATES.idle
				animationPlayer.play("Idle")

func StepProcess():
	match(state):
		STATES.idle:
			if attackTimer<=0 and CanISeePlayer():
				state=STATES.attack
				animationPlayer.play("Attack")
				attackTimer=1.5
			else:
				if position.distance_to(player.position)<160:
					state=STATES.idle
					animationPlayer.play("Idle")
				else:
					state=STATES.followPlayer
					animationPlayer.play("Walk")
		STATES.followPlayer:
				if position.distance_to(player.position)<160:
					if attackTimer<=0 and CanISeePlayer():
						state=STATES.attack
						animationPlayer.play("Attack")
						attackTimer=1.5
					else:
						state=STATES.idle
						animationPlayer.play("Idle")
		STATES.attack:
			pass
		STATES.hurt:
			pass

func Shoot():
	var ins = projectile.instance()
	ins.direction=(player.position-position).normalized()
	ins.position=position
	get_parent().add_child(ins)

func FinishedAttacking():
	state=STATES.idle

func CanISeePlayer():
	if player in detectPlayer.get_overlapping_bodies():
		seePlayer.cast_to=seePlayer.to_local(player.position)
		seePlayer.force_raycast_update()
		if seePlayer.get_collider()==player:
			return true
	return false

func Hurt(dam:int,sourcePoint:Vector2):
	animationPlayer.play("Hurt")
	state=STATES.hurt
	direction=(position-sourcePoint).normalized()
	hurtTimer=0.5
	health-=dam
	if health<=0:
		queue_free()

#Assign correct scales depending of input direction
func AssignCorrectDirection(dir:Vector2):
	if dir.x < 0:
		set_global_transform(Transform2D(Vector2(-1,0),Vector2(0,1),Vector2(position.x,position.y)))
	elif dir.x > 0:
		 set_global_transform(Transform2D(Vector2(1,0),Vector2(0,1),Vector2(position.x,position.y)))
