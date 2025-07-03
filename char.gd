extends RigidBody3D
class_name Char

func init(vel :Vector3, avel :Vector3) -> Char:
	linear_velocity = vel
	angular_velocity = avel
	return self

func set_material(mat :Material) -> Char:
	$MeshInstance3D.mesh.material = mat
	return self

func set_color(co :Color) -> Char:
	$MeshInstance3D.mesh.material.albedo_color = co
	return self

func get_color() -> Color:
	return $MeshInstance3D.mesh.material.albedo_color

func set_height_depth(h :float, d :float) -> Char:
	$MeshInstance3D.mesh.depth = d
	$CollisionShape3D.shape.size.y = d
	$CollisionShape3D.shape.size.z = h
	$MeshInstance3D.mesh.pixel_size = h/10
	$CollisionShape3D.shape.size.x = $CollisionShape3D.shape.size.z * 0.9 * $MeshInstance3D.mesh.text.length() 
	return self

func set_char(s :String) -> Char:
	$MeshInstance3D.mesh.text = s
	$CollisionShape3D.shape.size.x = $CollisionShape3D.shape.size.z * 0.9 * $MeshInstance3D.mesh.text.length() 
	return self
