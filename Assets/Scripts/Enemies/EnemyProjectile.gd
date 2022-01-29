extends KinematicBody2D

var direction : Vector2
var moveSpeed = 60

var damageTimer = 1 #1

var previouslyAttacked : Array

func _ready():
	var _a=$DamageHitbox.connect("body_entered",self,"BodyEnteredHitbox")

func _physics_process(delta):
	if damageTimer>0:
		damageTimer-=delta
	if direction==Vector2.ZERO:
		queue_free()
	var col = move_and_collide(direction*moveSpeed*delta)
	if col != null:
		if col.collider.has_method("Hurt") and not col.collider in previouslyAttacked:
			previouslyAttacked.append(col.collider)
			col.collider.Hurt(1,position)
		queue_free()

func BodyEnteredHitbox(body):
	if body.has_method("Hurt") and damageTimer<=0:
		previouslyAttacked.append(body)
		body.Hurt(1,position)
		queue_free()

func Bounce(dir):
	direction=dir
