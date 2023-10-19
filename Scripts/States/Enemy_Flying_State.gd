class_name EnemyFlyingState
extends State

var spawn_position : Vector2
var destination_position : Vector2
signal arrived_at_location

func _ready() -> void:
	self.spawn_position = self.actor.spawn_position
	self.destination_position = self.actor.destination_position
	self.set_physics_process(false)

func _enter_state() -> void:
	self.set_physics_process(true)
	if self.actor.global_position != self.spawn_position:
		self.actor.global_position = self.spawn_position
	#possible inheritance
	self.animator.play("Idle")

func _exit_state() -> void:
	self.set_physics_process(false)

func _physics_process(delta):
#	if self.actor.global_position.x != self.spawn_position.x:
#		self.actor.global_position.x = self.spawn_position.x
	self.actor.global_position.y += 1
	if self.actor.global_position.floor().y == self.destination_position.floor().y:
		self.arrived_at_location.emit()
		self.actor.hit_box_component.set_process(true)
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
