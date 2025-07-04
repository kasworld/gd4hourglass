extends RigidBody3D
class_name Coin

func init(vel :Vector3, avel :Vector3) -> Coin:
	linear_velocity = vel
	angular_velocity = avel
	return self

func set_segment(n :int) -> Coin:
	$MeshInstance3D.mesh.radial_segments = n
	return self

func set_material(mat :Material) -> Coin:
	$MeshInstance3D.mesh.material = mat
	return self

func set_color(co :Color) -> Coin:
	$MeshInstance3D.mesh.material.albedo_color = co
	return self

func get_color() -> Color:
	return $MeshInstance3D.mesh.material.albedo_color

func set_radius_height(r :float, h:float) -> Coin:
	$MeshInstance3D.mesh.top_radius = r
	$MeshInstance3D.mesh.bottom_radius = r
	$MeshInstance3D.mesh.height = h
	$CollisionShape3D.shape.radius = r
	$CollisionShape3D.shape.height = h
	return self
