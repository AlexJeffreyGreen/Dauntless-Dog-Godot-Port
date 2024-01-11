class_name PlayerFlyingState
extends EntityFlyingState



#var spawn_position : Vector2
#var destination_position : Vector2
#signal arrived_at_location
#
#func _ready() -> void:
#	self.spawn_position = self.actor.spawn_position
#	self.destination_position = self.actor.destination_position
#	self.set_physics_process(false)
#
#func _enter_state() -> void:
#	self.set_physics_process(true)
#	if self.actor.global_position != self.spawn_position:
#		self.actor.global_position = self.spawn_position
#	self.animator.play("Idle")
#
#func _exit_state() -> void:
#	self.set_physics_process(false)
#
#func _physics_process(delta):
#	self.actor.global_position.y += 1 * self.actor.max_speed
#	if self.actor.global_position.floor().y >= self.destination_position.floor().y:
#		self.actor.global_position.y = self.destination_position.y
#		self.arrived_at_location.emit()
#		self.actor.hit_box_component.set_process(true)

func _physics_process(delta):
	self.actor.global_position.y -= 1 * self.actor.max_speed
	if self.actor.global_position.floor().y <= self.destination_position.floor().y:
		self.actor.global_position.y = self.destination_position.y
		self.arrived_at_location.emit()
		self.actor.hit_box_component.set_process(true)
