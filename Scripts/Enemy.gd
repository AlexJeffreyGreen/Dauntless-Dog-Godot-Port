extends Area2D
class_name Enemy

@export var max_speed = 40
@export var acceleration = 50.0
@export var health : int = 3
@export var enemy_type : Contants.enemy_type = Contants.enemy_type.EYE
@onready var enemy_animated_sprite = $AnimatedSprite2D
@onready var ray_cast_2d : RayCast2D = $RayCast2D

@onready var enemy_flying_state : EnemyFlyingState = $FiniteStateMachine/EnemyFlyingState
@onready var enemy_attack_state : EnemyAttackState = $FiniteStateMachine/EnemyAttackState
@onready var enemy_idle_state : EnemyIdleState = $FiniteStateMachine/EnemyIdleState
@onready var finite_state_machine : FiniteStateMachine = $FiniteStateMachine


# Called when the node enters the scene tree for the first time.
func _ready():
	self.enemy_flying_state.arrived_at_location.connect(self.finite_state_machine._change_state.bind(self.enemy_idle_state))
	self.enemy_idle_state.saw_player.connect(self.finite_state_machine._change_state.bind(self.enemy_attack_state))
	self.enemy_attack_state.lost_player.connect(self.finite_state_machine._change_state.bind(self.enemy_idle_state))
	#self.player = get_parent().get_tree().get()
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass
	#self.ray_cast_2d.set_cast_to(Vector2.DOWN)
	#self.ray_cast_2d.target_position = Vector2.DOWN
	
	#var local = self.ray_cast_2d.to_local(Global.player.global_position)# = Global.player.transform #get_local_mouse_position()
	#self.ray_cast_2d.target_position = local
	#print(self.ray_cast_2d.target_position)
	#pass
	#self.ray_cast_2d.target_position = 

func _on_area_entered(area):
	print(area.name + " hit area")
	

func _on_body_entered(body):
	pass
