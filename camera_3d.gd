extends Camera3D


func _on_player_player_moved(movement_speed: float) -> void:
	var tween: Tween = self.create_tween()
	tween.tween_interval(0.8)
	tween.set_ease(Tween.EASE_OUT)
	
	var starting_value = 75 if movement_speed > 10 else 120
	var ending_value =  120 if movement_speed > 10 else 75
	
	self.fov = tween.interpolate_value(starting_value, ending_value - starting_value, 0.8, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
