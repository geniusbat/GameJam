extends Node2D

export(bool)var attacking = false
onready var attackArea = $AttackArea

onready var hitAudio = $HitAudio

var previouslyAttacked : Array

func _physics_process(_delta):
	if attacking:
		var bodies = attackArea.get_overlapping_bodies()
		var wasZero = previouslyAttacked.size()==0
		for body in bodies:
			if body.has_method("Hurt") and not body==get_parent():
				if !body in previouslyAttacked:
					previouslyAttacked.append(body)
					body.Hurt(1,get_parent().position)
			#Bounce projectiles and other
			elif body.has_method("Bounce"):
				if !body in previouslyAttacked:
					previouslyAttacked.append(body)
					body.Bounce((body.position-get_parent().position).normalized())
		if wasZero:
			if previouslyAttacked.size()!=0:
				hitAudio.play()
