extends KinematicBody2D

var health = 2
var moveSpeed = 40
var direction : Vector2

enum STATES {idle, followPlayer, attack, hurt}
var state = STATES.idle
export(bool) var damaging = false

var previouslyAttacked : Array

var attackTimer = 0.9 #0.9
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
			dir.x = -dir.x
			AssignCorrectDirection(dir)
		STATES.attack:
			if damaging:
				for el in meleeRange.get_overlapping_bodies():
					if not el==self and not el in previouslyAttacked:
						if el.has_method("Hurt"):
							el.Hurt(1,position)
							previouslyAttacked.append(el)
			#Move towards while attacking
			var dir = (player.position-position).normalized()
			var _a=move_and_slide(dir*moveSpeed*0.4)
			dir.x = -dir.x
			AssignCorrectDirection(dir)
		STATES.hurt:
			var _a=move_and_slide(direction*50)
			hurtTimer-=delta
			if hurtTimer<0:
				state=STATES.idle
				animationPlayer.play("Idle")

func StepProcess():
	match(state):
		STATES.idle:
			state=STATES.followPlayer
			animationPlayer.play("Walk")
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
				attackTimer=0.9
				animationPlayer.play("Attack")

func FinishedAttacking():
	state=STATES.idle
	animationPlayer.play("Idle")
	previouslyAttacked.clear()
	damaging=false

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
