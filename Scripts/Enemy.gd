extends CharacterBody2D
class_name Enemy

var attack_damage : float = 5
var stun_time : float = 0.0



@export var max_speed = 40
@export var acceleration = 50.0
@export var health : int = 3
@export var enemy_type : Contants.enemy_type = Contants.enemy_type.EYE
@onready var enemy_animated_sprite = $AnimatedSprite2D
@onready var ray_cast_2d : RayCast2D = $RayCast2D
@onready var bullet = preload("res://Scenes/enemy_bullet.gd")
@onready var flash_timer = $FlashTimer
@onready var enemy_flying_state : EnemyFlyingState = $FiniteStateMachine/EnemyFlyingState
@onready var enemy_attack_state : EnemyAttackState = $FiniteStateMachine/EnemyAttackState
@onready var enemy_idle_state : EnemyIdleState = $FiniteStateMachine/EnemyIdleState
@onready var finite_state_machine : FiniteStateMachine = $FiniteStateMachine


# Called when the node enters the scene tree for the first time.
func _ready():
	self.enemy_flying_state.arrived_at_location.connect(self.finite_state_machine._change_state.bind(self.enemy_idle_state))
	self.enemy_idle_state.saw_player.connect(self.finite_state_machine._change_state.bind(self.enemy_attack_state))
	self.enemy_attack_state.lost_player.connect(self.finite_state_machine._change_state.bind(self.enemy_idle_state))
	self.enemy_animated_sprite.material.set_shader_parameter("flash_modifier", 0)
	#self.player = get_parent().get_tree().get()
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

func _on_area_entered(area):
	print(area.name + " hit area")
	

func _on_body_entered(body):
	if body.has_method("damage"):
		var attack = Attack.new()
		attack.attack_damage = self.attack_damage
		attack.knockback_force = 1
		attack.attack_position = self.global_position
		body.damage(attack)

func _on_hitbox_component_area_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = self.attack_damage
		attack.knockback_force = 1
		attack.attack_position = self.global_position
		attack.stun_timer = self.stun_time
		hitbox.damage(attack)

func shoot(coords : Vector2):
	pass
	#skip animation	
func flash():
	self.enemy_animated_sprite.material.set_shader_parameter("flash_modifier", 1)
	self.flash_timer.start()

func _on_flash_timer_timeout():
	self.enemy_animated_sprite.material.set_shader_parameter("flash_modifier", 0)
