extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

func damage(attack: Attack):
	if self.health_component:
		self.health_component.damage(attack)
		self.get_parent().visual_component.flash()
