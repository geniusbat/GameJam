extends Area2D

func _ready():
	$AnimationPlayer.play("Idle")

func _process(delta):
	#Change alpha based on personality
	if PlayerInfo.personality==PlayerInfo.PERSONALITIES.corpusculo:
		modulate.a = lerp(modulate.a,0.1,6*delta)
	else:
		modulate.a = lerp(modulate.a,1,6*delta)

func _on_HealUp_body_entered(body):
	PlayerInfo.health+=1
	queue_free()
