class_name Player_StateOnGround
extends Player_StateMotion

#region State Functions
static func _get_state_name() -> String:
	return "player_on_ground"

## Initialize the state
func _enter() -> void:
	state_name = Player_StateOnGround._get_state_name()

## Clean up the state
func _exit() -> void:
	pass

func _handle_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("jump"):
		self.finished.emit(Player_StateJump._get_state_name())
	super._handle_input(_event)

func _update(_delta: float) -> void:
	super._update(_delta)
#endregion