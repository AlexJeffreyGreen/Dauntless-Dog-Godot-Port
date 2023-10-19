extends Bullet
class_name EnemyBullet

func _process(delta):
	if self.current_behavior == BULLET_BEHAVIOR.NORMAL:
		self.global_position.y += self.speed
