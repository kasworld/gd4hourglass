extends RigidBody3D
class_name Capsule

func init(vel :Vector3, avel :Vector3) -> Capsule:
	linear_velocity = vel
	angular_velocity = avel
	return self

func set_material(mat :Material) -> Capsule:
	$MeshInstance3D.mesh.material = mat
	return self

func set_color(co :Color) -> Capsule:
	$MeshInstance3D.mesh.material.albedo_color = co
	return self

func get_color() -> Color:
	return $MeshInstance3D.mesh.material.albedo_color

func set_radius_height(r :float, h:float) -> Capsule:
	$MeshInstance3D.mesh.radius = r
	$MeshInstance3D.mesh.height = h
	$CollisionShape3D.shape.radius = r
	$CollisionShape3D.shape.height = h
	return self
