class_name Player_StateMotion
extends Player_State

var _acceleration: float = 100.0
## The rate in which an object slows down. Should be between 0 and 1
var _deceleration: float = 0.01
var _friction: float = 5.0
var _max_speed: float = 15.0
var _movement_direction: Vector3:
	get:
		var input_direction: Vector2 = self.get_input_direction()
		return Vector3(input_direction.x, 0, input_direction.y).normalized()
var _movement_velocity: Vector3 = Vector3.ZERO

#region State Functions
static func _get_state_name() -> String:
	return "player_motion"

func _enter():
	state_name = Player_StateMotion._get_state_name()

func _exit():
	pass

func _handle_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("debug_restart"):
		self.finished.emit(Player_StateDash._get_state_name())
	super._handle_input(_event)

func _update(_delta: float) -> void:
	var input_direction: Vector2 = self.get_input_direction()

	if input_direction.length() > 0.0:
		var rotation_angle: float = Vector2(-input_direction.y, -input_direction.x).angle()
		var sophie_rotation_angle: float = Vector2(input_direction.y, input_direction.x).angle()

		self.player.debug_ray_cast.rotation.y = lerp_angle(self.player.debug_ray_cast.rotation.y, rotation_angle, _delta * 10.0)
		self.player.sophia_skin.rotation.y = lerp_angle(self.player.sophia_skin.rotation.y, sophie_rotation_angle, _delta * 10.0)
		self.player.sophia_skin._set_run_tilt(angle_difference(sophie_rotation_angle, self.player.sophia_skin.rotation.y))
	if self.player.velocity.y < 0.0 && self.state_name != Player_StateFall._get_state_name():
		self.finished.emit(Player_StateFall._get_state_name())

	self.handle_movement(_delta)
	self.player.movement_velocity = self._movement_velocity

	super._update(_delta)
#endregion

## Accelerate a Vector3 in a particular direction
static func accelerate(vel: Vector3, direction: Vector3, delta: float, accel_type: float, decel_type: float, max_vel: float) -> Vector3: 
	var accel_vel: float = accel_type * delta

	if (vel.length() + accel_vel > max_vel):
		accel_vel = move_toward(accel_vel, max_vel - (vel.length()), abs(decel_type))

	return vel + (direction * accel_vel)

## Apply a force to a Vector3 in a particular direction
static func apply_force(vel: Vector3, direction: Vector3, _delta: float, force_value: float) -> Vector3:
	return vel + (direction * force_value)

func get_input_direction() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")

func handle_movement(delta: float) -> void: 
	self._movement_velocity = Player_StateMotion.accelerate(self._movement_velocity, self._movement_direction, delta, 
		self._acceleration, self._deceleration, self._max_speed)
	self._movement_velocity = Player._handle_velocity_deceleration(self._movement_velocity, self._friction, delta)

	# var speed: float = self._movement_velocity.length()
	# if speed != 0:
	# 	var drop: float = speed * self._friction * delta
	# 	self._movement_velocity *= max(speed - drop, 0) / speed