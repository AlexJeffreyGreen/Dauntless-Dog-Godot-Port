class_name FiniteStateMachine
extends Node

@export var current_state : State

func _ready():
	self._change_state(self.current_state)

func _change_state(new_state: State):
	#run exit code
	if new_state is State:
		self.current_state._exit_state()
		new_state._enter_state()
		self.current_state = new_state
