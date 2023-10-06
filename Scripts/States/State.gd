class_name State
extends Node

signal state_finished

@export var actor : Enemy
@export var animator : AnimatedSprite2D
@export var vision_cast : RayCast2D



func _enter_state() -> void:
	pass
	
func _exit_state() -> void:
	pass
