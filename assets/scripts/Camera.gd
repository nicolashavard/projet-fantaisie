extends Node3D

@export var target : Node3D

@export_range(0.0, 2.0) var rotation_speed = PI/2
@export_range(0.0, 90.0) var tilt_limit = 70.0

@onready var inner = $InnerGimbal

func get_input_keyboard(delta):
	# Rotate outer gimbal around y axis
	var y_rotation = -Input.get_axis("camera_rotate_left", "camera_rotate_right")
	rotate_object_local(Vector3.UP, y_rotation * rotation_speed * delta)
	# Rotate inner gimbal around local x axis
	var x_rotation = -Input.get_axis("camera_rotate_up", "camera_rotate_down")
	inner.rotate_object_local(Vector3.RIGHT, x_rotation * rotation_speed * delta)

func _process(delta):
	get_input_keyboard(delta)
	var tilt_radians = deg_to_rad(tilt_limit)
	inner.rotation.x = clamp(inner.rotation.x, -tilt_radians, tilt_radians)
	if target:
		global_position = target.global_position
