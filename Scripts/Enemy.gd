extends CharacterBody2D
class_name Enemy

var attack_damage : float = 5
var stun_time : float = 0.0
var spawn_position : Vector2i = Vector2(0,-500)
var destination_position : Vector2i = Vector2(0,-151)


@export var max_speed = 40
@export var acceleration = 50.0
@export var health : int = 3
@export var enemy_type : Contants.enemy_type = Contants.enemy_type.EYE
@onready var enemy_animated_sprite = $AnimatedSprite2D
@onready var ray_cast_2d : RayCast2D = $RayCast2D
@onready var bullet = preload("res://Scenes/enemy_bullet.tscn")
@onready var enemy_flying_state : EnemyFlyingState = $FiniteStateMachine/EnemyFlyingState
@onready var enemy_attack_state : EnemyAttackState = $FiniteStateMachine/EnemyAttackState
@onready var enemy_idle_state : EnemyIdleState = $FiniteStateMachine/EnemyIdleState
@onready var finite_state_machine : FiniteStateMachine = $FiniteStateMachine
@onready var attack_timer = $AttackTimer
@onready var visual_component = $VisualComponent
var can_shoot : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	self.enemy_flying_state.arrived_at_location.connect(self.finite_state_machine._change_state.bind(self.enemy_idle_state))
	self.enemy_idle_state.saw_player.connect(self.finite_state_machine._change_state.bind(self.enemy_attack_state))
	self.enemy_attack_state.lost_player.connect(self.finite_state_machine._change_state.bind(self.enemy_idle_state))
	self.enemy_animated_sprite.material.set_shader_parameter("flash_modifier", 0)

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

func shoot_at(hit_box_component : HitboxComponent):
	if !self.can_shoot: return
	self.can_shoot = false
	self.attack_timer.start()
	var current_bullet = self.bullet.instantiate() as EnemyBullet
	self.add_child(current_bullet)
	current_bullet.set_as_top_level(true)
	current_bullet.global_transform = self.global_transform
	current_bullet.global_position.y += 16
	
	#self.enemy_animated_sprite.play("Shoot")



func _on_attack_timer_timeout():
	self.can_shoot = true
