extends Bullet
class_name EnemyBullet

func _process(delta):
	self.global_position.y += self.speed
