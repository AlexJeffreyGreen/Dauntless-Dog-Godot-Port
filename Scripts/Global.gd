extends Node

var audio_sound_effect_volume : float = 0
var player : Player

func _ready():
	Utils.loadGame()
	#test
	print(audio_sound_effect_volume)
	#Utils.saveGame()
