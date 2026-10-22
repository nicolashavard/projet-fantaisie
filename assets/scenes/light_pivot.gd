extends Node3D

@export var minutes_par_tour := 2.0

func _process(delta: float) -> void:
	if minutes_par_tour <= 0.0:
		return

	var radians_par_seconde := TAU / (minutes_par_tour * 60.0)
	rotate_x(radians_par_seconde * delta)
