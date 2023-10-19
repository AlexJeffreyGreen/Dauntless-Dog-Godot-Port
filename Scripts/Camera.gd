extends Camera2D
class_name DauntlessCamera

var start_shake = false
var shake_intensity : float = 0
var shake_dampening : float = 0

@onready var shake_timer = $Shaketimer

func _ready():
	Global.camera = self

func _process(delta):
	if self.start_shake == true:
		self.offset.x = randf_range(-1, 1) * self.shake_intensity
		self.offset.y = randf_range(-1, 1) * self.shake_intensity
		self.shake_intensity = lerp(self.shake_intensity, 0.0, self.shake_dampening)
	else:
		self.offset = Vector2(0,0)

func screen_shake(intensity : float, duration : float, dampening : float):
	self.shake_intensity = intensity
	self.shake_timer.wait_time = duration
	self.shake_dampening = dampening
	self.start_shake = true

func _on_shaketimer_timeout():
	self.start_shake = false
	#pass # Replace with function body.
