extends KinematicBody2D

var health = 2
var moveSpeed = 40
var direction : Vector2

enum STATES {idle, followPlayer, attack, hurt}
var state = STATES.idle

var previouslyAttacked : Array

var attackTimer = 1 #1
var hurtTimer = 0.5 #0.5

onready var player : KinematicBody2D = get_tree().get_root().find_node("PlayerCharacter",true,false)
onready var animationPlayer : AnimationPlayer = $AnimationPlayer
onready var meleeRange : Area2D = $MeleePlayer

func _physics_process(delta):
	if attackTimer>0:
		attackTimer-=delta
	match(state):
		STATES.idle:
			pass
		STATES.followPlayer:
			var dir = (player.position-position).normalized()
			var _a=move_and_slide(dir*moveSpeed)
		STATES.attack:
			for el in meleeRange.get_overlapping_bodies():
				if not el==self and not el in previouslyAttacked:
					if el.has_method("Hurt"):
						el.Hurt(1,position)
						previouslyAttacked.append(el)
		STATES.hurt:
			var _a=move_and_slide(direction*50)
			hurtTimer-=delta
			if hurtTimer<0:
				state=STATES.idle

func StepProcess():
	match(state):
		STATES.idle:
			state=STATES.followPlayer
		STATES.followPlayer:
			TryToAttack()
		STATES.attack:
			pass
		STATES.hurt:
			pass

func TryToAttack():
	if state==STATES.followPlayer or state==STATES.idle:
		if meleeRange.get_overlapping_bodies().size()>0:
			if attackTimer<=0:
				state=STATES.attack
				animationPlayer.play("Attack")

func FinishedAttacking():
	state=STATES.idle
	previouslyAttacked.clear()

func Hurt(dam:int,sourcePoint:Vector2):
	state=STATES.hurt
	direction=(position-sourcePoint).normalized()
	hurtTimer=0.5
	health-=dam
	if health<=0:
		queue_free()
