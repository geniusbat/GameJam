extends Area2D

var attackTime = 1.3 #1.3
var attackWait = 0.7 #0.7
var active = false
var bodiesIn := 0

var previouslyAttacked : Array

onready var sprite = $Sprite

func _ready():
	var _a=connect("body_entered",self,"BodyEntered")
	_a=connect("body_exited",self,"BodyExited")
	sprite.play("default")

func _process(delta):
	if active:
		attackTime-=delta
		if attackTime<=0:
			if bodiesIn>0:
				previouslyAttacked.clear()
				attackWait = 0.7
				attackTime=1.3
				active=true
				sprite.play("default")
				sprite.play("Active")
			else:
				active=false
				sprite.play("default")
		attackWait-=delta
		print(attackWait)
		if attackWait<=0:
			var bodies = get_overlapping_bodies()
			for el in bodies:
				if el.has_method("Hurt"):
					if not el in previouslyAttacked:
						el.Hurt(1,position)
						previouslyAttacked.append(el)

func BodyEntered(_body):
	if !active:
		previouslyAttacked.clear()
		attackWait = 0.7
		attackTime=1.3
		active=true
		sprite.play("Active")
	bodiesIn+=1

func BodyExited(_body):
	bodiesIn-=1
