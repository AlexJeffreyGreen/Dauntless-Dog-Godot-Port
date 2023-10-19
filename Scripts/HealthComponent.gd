extends Node2D
class_name HealthComponent

@export var MAX_HEALTH : float = 10.0
var health : float

func _ready():
	self.health = self.MAX_HEALTH

func damage(attack: Attack):
	self.health -= attack.attack_damage
	if self.health <= 0:
		self.get_parent().death()
