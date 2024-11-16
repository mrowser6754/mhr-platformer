class_name State 
extends Node

@warning_ignore("unused_signal")

## The state is about to be changed to a different state
signal finished(state_name: String)

## Name of the state. Should not be changed after being set in the _enter function.
var state_name: String = State._get_state_name()

#region State Functions
static func _get_state_name() -> String:
	return ""

## Initialize the state
func _enter() -> void:
	pass		

## Clean up the state
func _exit() -> void:
	pass

func _handle_input(_event: InputEvent) -> void:
	pass

func _update(_delta: float) -> void:
	pass
#endregion