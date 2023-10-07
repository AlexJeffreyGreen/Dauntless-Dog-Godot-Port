extends CharacterBody2D
class_name Player

var can_shoot : bool = false
@export var speed : float = 400
@export var flames_position = 64
@onready var flame_animation = $FlameAnimation
@onready var body_animation = $BodyAnimation
@onready var bullet = preload("res://Scenes/bullet.tscn")
@onready var bullet_timer = $BulletTimer as Timer
@onready var animation_player = $Muzzle/AnimationPlayer
@onready var muzzle = $Muzzle
@onready var shoot_sound = $Audio/Shoot as AudioStreamPlayer2D

func _ready():
	self.flame_animation.play("Idle")
	self.body_animation.play("Idle")
	Global.player = self
	pass

func _process(delta):
	pass
	
func _input(event):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	#print(input_direction)

	self.velocity = input_direction * self.speed
	self.flame_animation.global_position.y = self.global_position.y + self.flames_position
	
func _physics_process(delta):
	if (Input.is_action_just_pressed("Fire") || Input.is_action_pressed("Fire")) && self.can_shoot:
		self.shoot()
	self.process_movement_animations()
	self.move_and_slide()
	self.muzzle.global_position = self.global_position

func shoot():
	self.animation_player.play("Shoot")
	self.shoot_sound.play()
	self.can_shoot = false
	self.bullet_timer.start()#.start(.10)
	var currentBullet = self.bullet.instantiate() as Bullet
	self.add_child(currentBullet)
	currentBullet.set_as_top_level(true)
	currentBullet.global_transform = self.global_transform
	currentBullet.global_position.y -= 16
	
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


func _on_bullet_timer_timeout():
	self.can_shoot = true


func _on_animation_player_animation_finished(anim_name):
	pass

#func damage(attack: Attack):
#	self.health -= attack.attack_damage
#	if self.health <= 0:
#		self.queue_free()
