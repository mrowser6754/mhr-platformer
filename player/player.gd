class_name Player
extends CharacterBody3D

const _ACCELERATION_GROUNDED: float = 100.0
const _ACCELERATION_AIR: float = 10.0
const _MAX_SPEED_GROUNDED: float = 15.0 
const _MAX_SPEED_AIR: float = 15.0

@export var gravity: float = 25.0
@export var jump_force: float = 10.0
@export var dash_force: float = 80.0
@export var move_speed: float = 100.0

var dash_velocity: Vector3 = Vector3.ZERO
var jump_velocity: Vector3 = Vector3.ZERO
var movement_velocity: Vector3 = Vector3.ZERO
var _applied_gravity: float = 0.0
var _gravity_velocity: Vector3 = Vector3.ZERO

@onready var debug_model: MeshInstance3D = $DebugModel
@onready var debug_ray_cast: RayCast3D = $DebugRayCast
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var state_move: Player_StateMove = $PlayerStateMachine/Move
@onready var state_dash: Player_StateDash = $PlayerStateMachine/Dash
@onready var sophia_skin: SophiaAnimationHandler = $SophiaSkin

func _physics_process(delta: float) -> void:
	var input_direction: Vector2 = Player.get_input_direction()
	var rotation_angle: float = Vector2(-input_direction.y, -input_direction.x).angle()
	
	if self.player_state_machine.current_state is not Player_StateDash:
		self._handle_applied_gravity(delta)

	self.debug_ray_cast.rotation.y = rotation_angle


# State normally handles deceleration, this is for states that may restrict movement
	self.movement_velocity = Player._handle_velocity_deceleration(self.movement_velocity, self.state_move._friction, delta)
	self.dash_velocity = Player._handle_velocity_deceleration(self.dash_velocity, self.state_dash._friction, delta)

	self.velocity = self._get_velocity_sources()
	self.move_and_slide()

func _get_velocity_sources() -> Vector3:
	return self.dash_velocity + self.movement_velocity + self.jump_velocity + self._gravity_velocity

func _handle_applied_gravity(delta: float) -> void: 
	if self.is_on_floor(): self._applied_gravity = 0
	else: self._applied_gravity += (self.gravity * delta)

	self._gravity_velocity.y = -self._applied_gravity
	#print(self._gravity_velocity.y)

static func _handle_velocity_deceleration(vel: Vector3, frict: float, delta: float) -> Vector3:
	var speed: float = vel.length()
	if speed != 0:
		var drop: float = speed * frict * delta
		vel *= max(speed - drop, 0) / speed
	return vel

static func get_input_direction() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
