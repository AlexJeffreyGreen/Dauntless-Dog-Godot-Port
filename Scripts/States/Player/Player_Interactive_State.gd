class_name PlayerInteractiveState
extends State

func _ready():
	self.set_physics_process(false)

func _enter_state() -> void:
	self.set_physics_process(true)
	self.animator.play("Idle")

func _exit_state() -> void:
	self.set_physics_process(false)
