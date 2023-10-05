class_name EnemyWanderState
extends State

@export var actor : Enemy
@export var animator : AnimatedSprite2D
@export var vision_cast : RayCast2D

signal saw_player

func _ready():
	self.set_physics_process(false)

func _enter_state() -> void:
	self.set_physics_process(true)
	self.animator.play("Move")
	
	#if self.actor.speed == Vector2.ZERO:
	#	self.actor.velocity = Vector2.RIGHT.rotated(randf_range(0, TAU)) * self.actor.max_speed

func _exit_state() -> void:
	self.set_physics_process(false)

func _physics_process(delta):
	self.actor.global_position.y += 1#self.actor.max_speed
	#if we want to flip the sprite to move in our direction
	#self.animator.scale.x = -sign(self.actor.velocity.x)
	#if self.animator.scale.x == 0: self.animator.scale.x = 1.0
	#var collision = self.actor.move_and_collide(self.actor.velocity * delta)
	#if collision:
	#	var bounce_velocity = self.actor.velocity.bounce(collision.get_normal)
#		self.actor.velocity = bounce_velocity
