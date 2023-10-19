extends Node

var audio_sound_effect_volume : float = 0
var player : Player
var wave_spawner = load("res://Scripts/wave_spawner.tscn")
var camera : DauntlessCamera = null

func _ready():
	Utils.loadGame()
	#test
	print(audio_sound_effect_volume)
	#self.wave_spawner.instantiate() as WaveSpawner
	
#func _input(event):
#	if Input.is_action_just_pressed("Debug"):
#		self.spawn_next_wave()
#	#Utils.saveGame()
#func spawn_next_wave():
#	self.wave_spawner.spawn_wave()
