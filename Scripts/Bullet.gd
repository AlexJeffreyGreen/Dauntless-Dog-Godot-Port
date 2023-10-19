extends Area2D
class_name Bullet

@export var speed : float = 15
@export var attack_damage : int = 2
var stun_time : float = 1.5
enum BULLET_BEHAVIOR {NORMAL,SPREAD}
var current_behavior : BULLET_BEHAVIOR = BULLET_BEHAVIOR.NORMAL
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match(self.current_behavior):
		BULLET_BEHAVIOR.NORMAL:
			self.global_position.y -= self.speed
		BULLET_BEHAVIOR.SPREAD:
			pass

func _on_timer_timeout():
	self.queue_free()
	#pass # Replace with function body.

func _on_hitbox_component_area_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = self.attack_damage
		attack.knockback_force = 1
		attack.attack_position = self.global_position
		attack.stun_timer = self.stun_time
		hitbox.damage(attack)
		self.queue_free()
