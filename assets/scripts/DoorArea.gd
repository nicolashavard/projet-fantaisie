extends Area3D

var player_nearby := false

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_nearby = true

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_nearby = false

func _unhandled_input(event: InputEvent) -> void:
	if player_nearby and event.is_action_pressed("interact"):
		get_parent().get_parent().appuyer()
