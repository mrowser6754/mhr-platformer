class_name Player_StateDash
extends Player_State

@onready var timer: Timer = $Timer

var _dash_velocity: Vector3 = Vector3.ZERO
var _friction: float = 5.0

#region State Functions
static func _get_state_name() -> String:
	return "player_dash"

## Initialize the state
func _enter() -> void:
	self.state_name = Player_StateDash._get_state_name()
	self.timer.start()
	self.player.sophia_skin.fall()

	self._dash_velocity = self.player.dash_velocity
	self._dash_velocity = Player_StateMotion.apply_force(self.player.dash_velocity, self.player.movement_velocity.normalized(), 1.0, self.player.dash_force)

## Clean up the state
func _exit() -> void:
	self.timer.stop()

func _handle_input(_event: InputEvent) -> void:
	pass

func _update(_delta: float) -> void:
	self.player._applied_gravity = 0.0
	self.player._gravity_velocity = Vector3.ZERO
	self.player.jump_velocity = Vector3.ZERO
	self._dash_velocity = Player._handle_velocity_deceleration(self._dash_velocity, self._friction, _delta)
	self.player.dash_velocity = self._dash_velocity
#endregion

func _on_timer_timeout() -> void:
	self.finished.emit(StateMachine.STATE_NAME_PREVIOUS if self.player.is_on_floor() else Player_StateFall._get_state_name())
