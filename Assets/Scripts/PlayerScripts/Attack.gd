extends Node2D

var attacking = false
onready var attackArea = $AttackArea

var previouslyAttacked : Array

func _physics_process(delta):
	if attacking:
		var bodies = attackArea.get_overlapping_bodies()
		for body in bodies:
			if body.has_method("Hurt"):
				if !body in previouslyAttacked:
					previouslyAttacked.append(body)
					body.Hurt(1,get_parent().position)
