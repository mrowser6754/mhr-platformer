class_name Player_StateJump
extends Player_StateMotion

#region State Functions
static func _get_state_name() -> String:
	return "player_jump"

## Initialize the state
func _enter() -> void:
	self.state_name = Player_StateJump._get_state_name()
	self.player.sophia_skin.jump()
	
	self.player._applied_gravity = 0.0
	self._movement_velocity = self.player.movement_velocity
	self.player.jump_velocity = Player_StateMotion.apply_force(self.player.jump_velocity, player.up_direction, 1.0, self.player.jump_force)

## Clean up the state
func _exit() -> void:
	pass

func _handle_input(_event: InputEvent) -> void:
	super._handle_input(_event)

func _update(_delta: float) -> void:
	if self.player.is_on_floor():
		self.finished.emit(StateMachine.STATE_NAME_PREVIOUS)
	super._update(_delta)
#endregion
