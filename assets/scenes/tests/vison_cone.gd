@tool
extends MeshInstance3D

@export var distance_vue := 15.0:
	set(value):
		distance_vue = value
		_actualiser()

@export_range(1.0, 360.0) var angle_vue := 90.0:
	set(value):
		angle_vue = value
		_actualiser()

func _ready() -> void:
	_actualiser()

func _actualiser() -> void:
	var cone := CylinderMesh.new()
	cone.top_radius = 0.0
	cone.bottom_radius = distance_vue * tan(deg_to_rad(angle_vue / 2.0))
	cone.height = distance_vue
	cone.radial_segments = 32
	mesh = cone

	# L'axe Y du cylindre devient l'axe Z.
	rotation_degrees = Vector3(-90, 0, 0)

	# Le centre du cône est avancé devant le monstre.
	position = Vector3(0, 0, distance_vue / 2.0)

	var materiau := StandardMaterial3D.new()
	materiau.albedo_color = Color(1.0, 0.2, 0.1, 0.2)
	materiau.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	materiau.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material_override = materiau
