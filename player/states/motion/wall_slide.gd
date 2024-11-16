class_name Player_StateWallSlide
extends Player_StateMotion

#region State Functions
static func _get_state_name() -> String:
	return "player_wall_slide"

## Initialize the state
func _enter() -> void:
	self.player.sophia_skin.wall_slide()
	self.player.gravity = 5.0
	self.player._applied_gravity = 0.0
	self._movement_velocity = self.player.movement_velocity
	
## Clean up the state
func _exit() -> void:
	self.player.gravity = 25.0

func _handle_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("jump"):
		self.finished.emit(Player_StateJump._get_state_name())

func _update(_delta: float) -> void:
	#self.player._gravity_velocity.y = -15.0
	if self.player.is_on_floor():
		self.finished.emit(PlayerStateMachine.STATE_NAME_PREVIOUS)
#endregion