extends KinematicBody2D

onready var animationPlayer : AnimationPlayer = $AnimationPlayer

enum STATES {normal, hurt, stun, charging, initial}
var state = STATES.initial

var health = 4

var initialTimer = 0.4 #0.4

var damageAgainTimer = 0.5 #0.5
var damaged = false

var moveSpeed = 90
var direction : Vector2

onready var player = get_tree().get_root().find_node("PlayerCharacter",true,false)
onready var damageArea = $DamageArea

var chargeUpTimer = 1 #1

func _physics_process(delta):
	match(state):
		STATES.normal:
			if chargeUpTimer<=0:
				state=STATES.charging
				direction = (player.position-position).normalized()
				animationPlayer.play("Charging")
			else:
				chargeUpTimer-=delta
		STATES.hurt:
			pass
		STATES.stun:
			pass
		STATES.charging:
			if !damaged:
				if damageArea.get_overlapping_bodies().size()!=0:
					damageArea.get_overlapping_bodies()[0].Hurt(2,position)
					damaged=true
					damageAgainTimer=0.5
			else:
				damageAgainTimer-=delta
				if damageAgainTimer<=0:
					damaged=false
			var col = move_and_collide(direction*moveSpeed*delta)
			AssignCorrectDirection(-direction)
			if col!=null and col.collider.get_name()!="PlayerCharacter":
				state=STATES.stun
				animationPlayer.play("Stun")
		STATES.initial:
			initialTimer-=delta
			if initialTimer<=0:
				state=STATES.normal
				animationPlayer.play("Idle")

func Hurt(dam,_sourcePoint):
	if state==STATES.stun:
		health-=dam
		state=STATES.hurt
		animationPlayer.play("Hurt")
		if health<=0:
			Die()

func Die():
	visible=false
	set_collision_layer_bit(3,false)
	$DamageArea.monitoring=false
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene_to(load("res://Levels/Event levels/PostBoss.tscn"))

func DonedStun():
	state=STATES.normal
	animationPlayer.play("Idle")
	chargeUpTimer=0.5

func DoneHurt():
	state=STATES.normal
	animationPlayer.play("Idle")
	chargeUpTimer=1


func AssignCorrectDirection(dir:Vector2):
	if dir.x < 0:
		set_global_transform(Transform2D(Vector2(-1,0),Vector2(0,1),Vector2(position.x,position.y)))
	elif dir.x > 0:
		 set_global_transform(Transform2D(Vector2(1,0),Vector2(0,1),Vector2(position.x,position.y)))
