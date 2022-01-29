extends Node

enum PERSONALITIES {onda, corpusculo}
var personality = PERSONALITIES.corpusculo

func ChangePersonality():
	match(personality):
		PERSONALITIES.corpusculo:
			personality=PERSONALITIES.onda
		PERSONALITIES.onda:
			personality=PERSONALITIES.corpusculo
