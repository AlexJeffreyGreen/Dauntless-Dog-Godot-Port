class_name EnemyIdleState
extends State

signal saw_player

func _ready():
	self.set_physics_process(false)

func _enter_state() -> void:
	self.set_physics_process(true)
	self.animator.play("Idle")

func _exit_state() -> void:
	self.set_physics_process(false)

func _physics_process(delta):
	self.vision_cast.target_position = Vector2(0, self.actor.get_viewport_rect().size.y)
	if self.vision_cast.is_colliding() && self.vision_cast.get_collider() != null && self.vision_cast.get_collider().get_parent() != null:
		var currentColl = self.vision_cast.get_collider().get_parent()
		if currentColl is Player:
			self.saw_player.emit()
