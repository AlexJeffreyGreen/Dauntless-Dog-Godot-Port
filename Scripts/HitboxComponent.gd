extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

func damage(attack: Attack):
	if self.health_component:
		self.health_component.damage(attack)
		self.get_parent().visual_component.flash()
		AudioManager.play(AudioManager.SOUND_EFFECT.HIT)
		#self.get_parent().audio_component.Play(AudioComponent.SOUND_EFFECT.HIT)
		#self.get_parent().audio_component.hit
