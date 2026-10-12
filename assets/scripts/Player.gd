extends CharacterBody3D

var camera: Node3D
@export var speed = 5.0
@export var jump_velocity = 4.5

@onready var anim_tree = $AnimationTree
@onready var anim_state = $AnimationTree.get("parameters/playback")

var target_velocity = Vector3.ZERO
var jumping = false
var last_floor = true

func _ready() -> void:
	camera = %Camera


func _physics_process(delta):
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		target_velocity.y = jump_velocity
		jumping = true
		anim_tree.set("parameters/conditions/grounded", false)
	anim_tree.set("parameters/conditions/jumping", jumping)
	
	# We just hit the floor after being in the air
	if is_on_floor() and not last_floor:
		jumping = false
		anim_tree.set("parameters/conditions/grounded", true)
	last_floor = is_on_floor()
	
	# We're in the air, but we didn't jump
	if not is_on_floor() and not jumping:
		anim_state.travel("Jump_Idle")
		anim_tree.set("parameters/conditions/grounded", false)

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = input_dir.rotated(-camera.rotation.y)

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.y * speed
	
	# No rotation if not moving forward
	if direction != Vector2.ZERO:
		rotation.y = camera.rotation.y

	# Add the gravity.
	if not is_on_floor():
		target_velocity += get_gravity() * delta

	# Moving the Character
	velocity = target_velocity
	var vl = velocity * transform.basis
	anim_tree.set("parameters/IWR/blend_position", Vector2(vl.x, -vl.z) / speed)
	move_and_slide()
