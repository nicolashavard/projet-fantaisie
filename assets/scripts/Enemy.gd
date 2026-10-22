extends CharacterBody3D

@onready var rayon: RayCast3D = %Rayon
@onready var anim_tree = $AnimationTree
@onready var anim_state = $AnimationTree.get("parameters/playback")
@export var vitesse := 3.0

var player: CharacterBody3D

func _physics_process(_delta: float) -> void:
	if player == null:
		return

	# La cible de RayCast3D est exprimée dans l'espace local du rayon.
	rayon.target_position = rayon.to_local(Vector3(player.global_position.x, player.global_position.y +1.5, player.global_position.z))
	rayon.force_raycast_update()
	
	var is_player_visible := false

	if rayon.is_colliding():
		var touched_object = rayon.get_collider()
		is_player_visible = touched_object == player

		if is_player_visible:
			print("Le joueur est visible")
			anim_tree.set("parameters/conditions/walking", true)
			anim_tree.set("parameters/conditions/not_walking", false)
			move_to_player()
		else:
			print("Le joueur est derrière un obstacle")
			velocity.x = 0.0
			velocity.z = 0.0
			anim_tree.set("parameters/conditions/walking", false)
			anim_tree.set("parameters/conditions/not_walking", true)
		
		move_and_slide()

func _process(delta: float) -> void:
	pass


func _on_vision_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player = body
		print("Joueur repéré")


func _on_vision_field_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player = null
		print("Joueur perdu de vue")


func move_to_player() -> void:
	
	var direction := player.global_position - global_position
	direction.y = 0.0 # Le monstre reste au sol.

	if direction.length_squared() > 0.001:
		direction = direction.normalized()
		velocity.x = direction.x * vitesse
		velocity.z = direction.z * vitesse

	# Tourne le monstre vers le joueur.
		look_at(
			Vector3(player.global_position.x, global_position.y, player.global_position.z),
			Vector3.UP
		)
