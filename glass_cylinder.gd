extends StaticBody3D
class_name GlassCylinder

func _ready() -> void:
	set_color( Color(NamedColorList.color_list.pick_random()[0], 0.5) )

func set_material(mat :Material) -> GlassCylinder:
	$MeshInstance3D.mesh.material = mat
	return self

func set_color(co :Color) -> GlassCylinder:
	$MeshInstance3D.mesh.material.albedo_color = co
	return self

func get_color() -> Color:
	return $MeshInstance3D.mesh.material.albedo_color
