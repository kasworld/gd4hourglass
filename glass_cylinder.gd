extends StaticBody3D
class_name GlassCylinder

func set_material(mat :Material) -> GlassCylinder:
	$MeshInstance3D.mesh.material = mat
	return self

func set_color(co :Color) -> GlassCylinder:
	$MeshInstance3D.mesh.material.albedo_color = co
	return self

func get_color() -> Color:
	return $MeshInstance3D.mesh.material.albedo_color
