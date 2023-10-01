extends CharacterBody2D
class_name Player

@export var speed : float = 400
@export var flames_position = 64
@onready var flame_animation = $FlameAnimation
@onready var body_animation = $BodyAnimation
@onready var bullet = preload("res://Scenes/bullet.tscn")
@onready var muzzle_animation_sprite = %MuzzleAnimationSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	self.flame_animation.play("Idle")
	self.body_animation.play("Idle")
	self.muzzle_animation_sprite.stop()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	#print(input_direction)

	self.velocity = input_direction * self.speed
	self.flame_animation.global_position.y = self.global_position.y + self.flames_position
	
func _physics_process(delta):
	if Input.is_action_just_pressed("Fire"):
		self.shoot()
	self.process_movement_animations()
	self.move_and_slide()

func shoot():
	var currentBullet = self.bullet.instantiate() as Bullet
	self.add_child(currentBullet)
	currentBullet.set_as_top_level(true)
	currentBullet.global_transform = self.global_transform
	currentBullet.global_position.y -= 16
	if !self.muzzle_animation_sprite.visible: 
		self.muzzle_animation_sprite.visible = true
	self.muzzle_animation_sprite.play("Shoot")
	
	#self.bullet.global_position.x = self.global_position.x
	#self.bullet.global_position.y = self.global_position.y

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


func _on_muzzle_animation_sprite_animation_finished():
	self.muzzle_animation_sprite.visible = false
	self.muzzle_animation_sprite.stop()
	#pass # Replace with function body.
