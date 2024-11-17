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
		print(self.player.get_wall_normal())
		
		self.player.movement_velocity = Player_StateMotion.apply_force(self.player.movement_velocity, self.player.get_wall_normal(), 1.0, self.player.jump_force * 3)
		self.finished.emit(Player_StateJump._get_state_name())

func _update(_delta: float) -> void:
	#self.player._gravity_velocity.y = -15.0
	var direction: Vector2 = Vector2(self.player.rotation.x, self.player.rotation.z)
	print(direction)
	
	if self.player.is_on_floor() or not self.player.debug_ray_cast.is_colliding():
		self.finished.emit(PlayerStateMachine.STATE_NAME_PREVIOUS)
#endregion
