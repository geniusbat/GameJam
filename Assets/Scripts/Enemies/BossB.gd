extends KinematicBody2D

onready var animationPlayer : AnimationPlayer = $AnimationPlayer

enum STATES {normal, hurt, stun, charging, initial}
var state = STATES.initial

var initialTimer = 0.4

func _physics_process(delta):
	match(state):
		STATES.normal:
			pass
		STATES.hurt:
			pass
		STATES.stun:
			pass
		STATES.charging:
			pass
		STATES.initial:
			initialTimer-=delta
			if initialTimer<=0:
				state=STATES.normal
