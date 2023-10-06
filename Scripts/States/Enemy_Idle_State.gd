class_name EnemyIdleState
extends State


signal saw_player

func _ready():
	self.set_physics_process(false)

func _enter_state() -> void:
	self.set_physics_process(true)
	self.animator.play("Idle")
	
	#if self.actor.speed == Vector2.ZERO:
	#	self.actor.velocity = Vector2.RIGHT.rotated(randf_range(0, TAU)) * self.actor.max_speed

func _exit_state() -> void:
	self.set_physics_process(false)

func _physics_process(delta):
	self.vision_cast.target_position = Vector2(0, self.actor.get_viewport_rect().size.y)
	#var local = self.ray_cast_2d.to_local(Vector2(get_viewport_rect().size.x, get_viewport_rect().size.x))
	#self.ray_cast_2d.target_position = local
	#self.ray_cast_2d.to_global(Vector2(0, 180))
	
	
	if self.vision_cast.is_colliding():
		self.saw_player.emit()
		#self.finite_state_machine._change_state(EnemyAttackState)
		#print("Player in ray")
		pass
	
