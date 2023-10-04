extends Area2D
class_name Bullet

@export var speed : float = 15
@export var damage : int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#print("called bullet")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.global_position.y -= self.speed
	
	#if self.global_position.y >= 500:
	#	self.queue_free()

func _on_timer_timeout():
	self.queue_free()
	#pass # Replace with function body.
