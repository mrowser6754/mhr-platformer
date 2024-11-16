class_name StateMachine
extends Node

signal state_changed(state_name: String)

const STATE_NAME_PREVIOUS: String = "previous"

var states_map: Dictionary = {}
var states_stack: Array = []
var current_state: State

@export var start_state: State

func _enter_tree() -> void:
	if not self.start_state:
		self.start_state = self.get_child(0)
	for child: State in self.get_children():
		child.finished.connect(_change_state)
		
	self.initialize(self.start_state)

func initialize(initial_state: State) -> void:
	self.states_stack.push_front(initial_state)
	self.current_state = self.states_stack[0]
	self.current_state._enter()

func _physics_process(delta):
	self.current_state._update(delta)

func _unhandled_input(event: InputEvent) -> void:
	self.current_state._handle_input(event)

func _change_state(state_name: String) -> void:
	self.current_state._exit()
	
	if state_name == StateMachine.STATE_NAME_PREVIOUS:
		self.states_stack.pop_front()
	else:
		self.states_stack[0] = self.states_map[state_name]
		 
	if self.states_stack.size() == 0:
		self.states_stack.push_front(self.start_state)
	self.current_state = self.states_stack[0]

	self.state_changed.emit(self.current_state.state_name)
	
	# if state_name != StateMachine.STATE_NAME_PREVIOUS:
	self.current_state._enter()
