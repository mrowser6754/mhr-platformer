extends Control

@export var character: Player

@onready var label_player_state_value: Label = %LabelPlayerStateValue
@onready var label_actual_velocity_value: Label = %LabelActualVelocityValue
@onready var label_proj_velocity_value: Label = %LabelProjVelocityValue
@onready var label_x_value: Label = %LabelXValue
@onready var label_y_value: Label = %LabelYValue
@onready var label_z_value: Label = %LabelZValue


func _process(_delta: float) -> void:
	var h_vel: Vector3 = Vector3(self.character.movement_velocity.x, 0, self.character.movement_velocity.z)
	
	self.label_x_value.text = str(snappedf(self.character.velocity.x, 0.001))
	self.label_y_value.text = str(snappedf(self.character.velocity.y, 0.001))
	self.label_z_value.text = str(snappedf(self.character.velocity.z, 0.001))
	self.label_actual_velocity_value.text = str(snappedf(h_vel.length(), 0.001))

func _on_player_player_moved(movement_speed: float) -> void:
	self.label_proj_velocity_value.text = str(snappedf(movement_speed, 0.001))

func _on_player_state_machine_state_changed(state_name: String) -> void:
	self.label_player_state_value.text = state_name
