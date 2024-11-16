class_name Player_State
extends State

@warning_ignore("unused_signal")

var player: Player:
    get: 
        return self.owner

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