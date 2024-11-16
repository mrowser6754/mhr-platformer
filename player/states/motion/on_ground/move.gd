class_name Player_StateMove
extends Player_StateOnGround

#region State Functions
static func _get_state_name() -> String:
	return "player_move"

func _enter() -> void:
	state_name = Player_StateMove._get_state_name()
	self.player.sophia_skin.move()

	self._movement_velocity = self.player.movement_velocity

func _exit() -> void:
	pass

func _handle_input(_event: InputEvent) -> void:
	super._handle_input(_event)

func _update(_delta: float) -> void:
	if self._movement_direction.is_zero_approx() && snappedf(self._movement_velocity.length(), 0.1) == 0.00:
		self.finished.emit(Player_StateIdle._get_state_name())
	super._update(_delta)
#endregion