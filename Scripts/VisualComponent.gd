extends Node
class_name VisualComponent

@export var sprite : AnimatedSprite2D
@export var timer_duration : float = .1
@export var flash_timer : Timer

func flash():
	self.sprite.material.set_shader_parameter("flash_modifier", 1)
	self.flash_timer.start()

func _on_timer_timeout():
	self.sprite.material.set_shader_parameter("flash_modifier", 0)
