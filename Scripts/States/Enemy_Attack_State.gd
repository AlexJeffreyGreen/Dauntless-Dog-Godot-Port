class_name EnemyAttackState
extends State

signal lost_player

func _ready() -> void:
	self.set_physics_process(false)

func _enter_state() -> void:
	self.set_physics_process(true)
	#possible inheritance
	self.animator.play("Move")

func _exit_state() -> void:
	self.set_physics_process(false)

func _physics_process(delta):
	if not self.vision_cast.is_colliding():
		self.lost_player.emit()
	#shoot at player's position on the x
	#pass
	#self.actor.global_position.y += 1#self.actor.max_speed
	#if we want to flip the sprite to move in our direction
	#self.animator.scale.x = -sign(self.actor.velocity.x)
	#if self.animator.scale.x == 0: self.animator.scale.x = 1.0
	#var collision = self.actor.move_and_collide(self.actor.velocity * delta)
	#if collision:
	#	var bounce_velocity = self.actor.velocity.bounce(collision.get_normal)
#		self.actor.velocity = bounce_velocity
