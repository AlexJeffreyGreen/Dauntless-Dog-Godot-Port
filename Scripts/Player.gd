extends CharacterBody2D
class_name Player

@export var speed : float = 400
@export var flames_position = 64
@onready var flame_animation = $FlameAnimation
@onready var body_animation = $BodyAnimation

# Called when the node enters the scene tree for the first time.
func _ready():
	self.flame_animation.play("Idle")
	self.body_animation.play("Idle")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	print(input_direction)

	self.velocity = input_direction * self.speed
	self.flame_animation.global_position.y = self.global_position.y + self.flames_position
	
func _physics_process(delta):
	self.process_movement_animations()
	self.move_and_slide()

#TODO deem if needed
func process_movement_animations():
	var movement_animation: String
	if Input.is_action_pressed("Left"):
		movement_animation = "Left"		
	elif Input.is_action_pressed("Right"):
		movement_animation = "Right"
	else:
		movement_animation = "Idle"
	self.body_animation.play(movement_animation)
