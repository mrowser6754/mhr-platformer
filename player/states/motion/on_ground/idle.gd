class_name Player_StateIdle
extends Player_StateOnGround

#region State Functions
static func _get_state_name() -> String:
	return "player_idle"

func _enter() -> void: 
	state_name = Player_StateIdle._get_state_name()

	if self.player: 
		if self.player.sophia_skin: 
			self.player.sophia_skin.idle()
		self._movement_velocity = self.player.movement_velocity

func _exit() -> void:
	pass

func _handle_input(_event: InputEvent) -> void:
	super._handle_input(_event)

func _update(_delta: float):
	var input_direction: Vector2 = self.get_input_direction()
	if input_direction: 
		self.finished.emit(Player_StateMove._get_state_name())
	super._update(_delta)
#endregion