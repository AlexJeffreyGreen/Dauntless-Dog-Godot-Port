class_name Entity
extends CharacterBody2D

@export var speed : float = 400
@onready var finite_state_machine : FiniteStateMachine = $FiniteStateMachine

var spawn_position : Vector2i = Vector2i.ZERO
var destination_position: Vector2i = Vector2i.ZERO
var explosion = preload("res://Scenes/explosion.tscn")
var states = {}

func _ready() -> void:
	self.fill_states()
	self.chain_signals()
	
## Fills the finite state machine with states that are children of the state machine.
func fill_states() -> void:#{key: String, value: State}:
	var tmp = {}
	for child in self.finite_state_machine.get_children():
		self.states[child.name] = child

## Chains all signals together to trigger each other on completion.
func chain_signals() -> void:
	pass

