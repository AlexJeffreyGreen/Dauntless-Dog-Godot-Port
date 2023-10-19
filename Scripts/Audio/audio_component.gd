extends Node
class_name AudioComponent

@export var shoot : AudioStreamPlayer2D
@export var hit : AudioStreamPlayer2D


enum SOUND_EFFECT {SHOOT, HIT, FLYING}

func Play(sound : SOUND_EFFECT):
	match sound:
		SOUND_EFFECT.SHOOT:
			shoot.play()
		SOUND_EFFECT.HIT:
			hit.play()
