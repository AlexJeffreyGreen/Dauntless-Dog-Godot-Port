extends CPUParticles2D
class_name Explosion

func _ready():
	self.emitting = true

func _process(delta):
	if self.emitting == false:
		self.queue_free()
