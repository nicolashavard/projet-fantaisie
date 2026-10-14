extends Node3D

@onready var animation_player = $AnimationPlayer
var is_door_open = false

func appuyer() -> void:
	if is_door_open:
		animation_player.play("CloseDoor")
		is_door_open = false
	else:
		animation_player.play("OpenDoor")
		is_door_open = true
