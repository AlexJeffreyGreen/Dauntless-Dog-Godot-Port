class_name Entity
extends CharacterBody2D

@export var speed : float = 400
@onready var finite_state_machine : FiniteStateMachine = $FiniteStateMachine

var spawn_position : Vector2i = Vector2i.ZERO
var destination_position: Vector2i = Vector2i.ZERO
var explosion = preload("res://Scenes/explosion.tscn")
var states = {}
var can_shoot = false

func _ready() -> void:
	self.fill_states()
	self.chain_signals()
	var timer = self.get_node('BulletTimer') as Timer
	timer.timeout.connect(self.bullet_timer_timeout.bind())
	
## Fills the finite state machine with states that are children of the state machine.
func fill_states() -> void:#{key: String, value: State}:
	var tmp = {}
	for child in self.finite_state_machine.get_children():
		self.states[child.name] = child

## Chains all signals together to trigger each other on completion.
func chain_signals() -> void:
	pass
	
## Bullet time between shots
func bullet_timer_timeout():
	self.can_shoot = true
	
## Returns the health component of the associated entity
func get_health() -> int:
	return self.get_node("HealthComponent").health

## Death handler
func dealth():
	pass
