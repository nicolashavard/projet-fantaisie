extends Area3D

var joueur_proche := false

func _on_interaction_zone_body_entered(body: Node3D) -> void:
	print("Entrée dans la zone :", body.name)
	
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		joueur_proche = true

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		joueur_proche = false

func _unhandled_input(event: InputEvent) -> void:
	if joueur_proche and event.is_action_pressed("interagir"):
		get_parent().appuyer()
