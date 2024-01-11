extends CharacterBody2D
class_name Enemy

@export var enemy_attributes : Enemy_Attributes

var attack_damage : float = 5
var stun_timer : float = 0.0
var spawn_position : Vector2i = Vector2(0,-500)
var destination_position : Vector2i = Vector2(0,-151)
var enemy_type : Enemy_Attributes.ENEMY_TYPE

var explosion = preload("res://Scenes/explosion.tscn")

@export var max_speed = 5
@export var acceleration = 50.0
@export var health : int = 3
@onready var enemy_animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d : RayCast2D = $RayCast2D
@onready var bullet = preload("res://Scenes/enemy_bullet.tscn")
@onready var enemy_flying_state : EntityFlyingState = $FiniteStateMachine/EnemyFlyingState
@onready var enemy_attack_state : EnemyAttackState = $FiniteStateMachine/EnemyAttackState
@onready var enemy_idle_state : EnemyIdleState = $FiniteStateMachine/EnemyIdleState
@onready var enemy_dive_state : EnemyDiveState = $FiniteStateMachine/EnemyDiveState
@onready var finite_state_machine : FiniteStateMachine = $FiniteStateMachine
@onready var attack_timer : Timer = $AttackTimer
@onready var visual_component = $VisualComponent
@onready var hit_box_component = $HitboxComponent
#@onready var audio_component = $AudioComponent as AudioComponent
var can_shoot : bool = true
signal death_signal


# Called when the node enters the scene tree for the first time.
func _ready():
	self.enemy_flying_state.arrived_at_location.connect(self.finite_state_machine._change_state.bind(self.enemy_idle_state))
	self.enemy_idle_state.saw_player.connect(self.finite_state_machine._change_state.bind(self.enemy_attack_state))
	self.enemy_attack_state.lost_player.connect(self.finite_state_machine._change_state.bind(self.enemy_idle_state))
	self.enemy_dive_state.dive_complete.connect(self.finite_state_machine._change_state.bind(self.enemy_flying_state))
	self.enemy_idle_state.dive_at_player.connect(self.finite_state_machine._change_state.bind(self.enemy_dive_state))
	self.enemy_animated_sprite.material.set_shader_parameter("flash_modifier", 0)
	self.hit_box_component.set_process(false)
	self.parse_enemy_attributes()
	#self.enemy_animated_sprite.sprite_frames.
	#self.enemy_animated_sprite.sprite_frames = self.enemy_attribute.attack_animation

func parse_enemy_attributes():
	self.enemy_animated_sprite.sprite_frames = self.enemy_attributes.sprite_frames
	self.health = self.enemy_attributes.health
	self.attack_damage = self.enemy_attributes.attack
	self.attack_timer.wait_time = self.enemy_attributes.attack_timer
	self.stun_timer = self.enemy_attributes.stun_timer
	self.enemy_type = self.enemy_attributes.enemy_type

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
		if !area.get_parent().is_in_group("player"): return
		var hitbox : HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = self.attack_damage
		attack.knockback_force = 1
		attack.attack_position = self.global_position
		attack.stun_timer = self.stun_timer
		#weird hitbox issue
		hitbox.damage(attack)

func shoot_at(hit_box_component : HitboxComponent):
	if !self.can_shoot: return
	self.can_shoot = false
	self.attack_timer.start()
	var current_bullet = self.bullet.instantiate() as EnemyBullet
	current_bullet.current_behavior = Bullet.BULLET_BEHAVIOR.NORMAL
	self.add_child(current_bullet)
	current_bullet.set_as_top_level(true)
	current_bullet.global_transform = self.global_transform
	current_bullet.global_position.y += 16
	AudioManager.play(AudioManager.SOUND_EFFECT.SHOOT)

func _on_attack_timer_timeout():
	self.can_shoot = true

func death():
	Global.camera.screen_shake(5.0,5.0,0.05)
	#self.audio_component.Play(AudioComponent.SOUND_EFFECT.HIT) #TODO change to EXPLODE when ready
	AudioManager.play(AudioManager.SOUND_EFFECT.EXPLODE)
	self.death_signal.emit()
	var explosion = self.explosion.instantiate() as Explosion
	explosion.global_position = self.global_position
	self.get_tree().current_scene.add_child(explosion)
	self.queue_free()
