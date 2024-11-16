extends Panel

@export var debug_ui: Control

func _process(_delta):
	var states_names = ""
	var numbers = ""
	var index = 0
	for state in debug_ui.character.player_state_machine.states_stack:
		states_names += String(state.get_name()) + "\n"
		numbers += str(index) + "\n"
		index += 1
	%States.text = states_names
	%Numbers.text = numbers