extends Node



enum SOUND_EFFECT {SHOOT, HIT, FLYING, EXPLODE}

func play(sound : SOUND_EFFECT):
	var player = AudioStreamPlayer.new()
	match sound:
		SOUND_EFFECT.SHOOT:
			player.stream = load("res://Assets/Audio/basic_shoot.wav")
			#shoot.play()
		SOUND_EFFECT.EXPLODE:
			player.stream = load("res://Assets/Audio/basic_explosion.wav")
		SOUND_EFFECT.HIT:
			player.stream = load("res://Assets/Audio/basic_hit.wav")
	player.connect("finished", player.queue_free)
	add_child(player)
	player.play()
