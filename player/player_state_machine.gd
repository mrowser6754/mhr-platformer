class_name PlayerStateMachine
extends StateMachine

@onready var player: Player = $".."
@onready var idle: State = $Idle
@onready var jump: State = $Jump
@onready var move: State = $Move
@onready var dash: State = $Dash
@onready var fall: State = $Fall

func _enter_tree() -> void:
	super._enter_tree()

func _ready() -> void:
	self.states_map = {
		Player_StateIdle._get_state_name() : self.idle,
		Player_StateJump._get_state_name() : self.jump,
		Player_StateFall._get_state_name() : self.fall,
		Player_StateMove._get_state_name() : self.move,
		Player_StateDash._get_state_name() : self.dash
	}
	print(self.states_map)

func _change_state(state_name: String) -> void:
	if state_name in [Player_StateJump._get_state_name()]:
		self.states_stack.push_front(self.states_map[state_name])

	super._change_state(state_name)

func _unhandled_input(event: InputEvent) -> void:
	super._unhandled_input(event)