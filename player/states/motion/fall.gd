class_name Player_StateFall
extends Player_StateMotion

#region State Functions
static func _get_state_name() -> String:
	return "player_fall"

## Initialize the state
func _enter() -> void:
	state_name = Player_StateFall._get_state_name()
	self.player.sophia_skin.fall()
	
	self._movement_velocity = self.player.movement_velocity

## Clean up the state
func _exit() -> void:
	self.player.jump_velocity = Vector3.ZERO

func _handle_input(_event: InputEvent) -> void:
	super._handle_input(_event)

func _update(_delta: float) -> void:
	if self.player.is_on_floor():
		self.finished.emit(StateMachine.STATE_NAME_PREVIOUS)
	elif self.player.is_on_wall() and self.player.debug_ray_cast.is_colliding():
		self.finished.emit(Player_StateWallSlide._get_state_name())
	super._update(_delta)

#endregion
