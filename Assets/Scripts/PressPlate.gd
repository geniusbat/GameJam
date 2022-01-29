extends Area2D

var bodiesIn := 0

var active = false
signal activated 

func BodyIn(_body):
	bodiesIn +=1
	if !active:
		emit_signal("activated")
	active=true


func BodyExited(_body):
	bodiesIn -=1
	if bodiesIn==0:
		active=false
