extends StaticBody3D
class_name Brick

func _ready() -> void:
	set_color(NamedColorList.color_list.pick_random()[0])

func set_material(mat :Material) -> Brick:
	$MeshInstance3D.mesh.material = mat
	return self

func set_color(co :Color) -> Brick:
	$MeshInstance3D.mesh.material.albedo_color = Color(co, 0.5)
	return self

func set_broken_effect() -> void:
	collision_layer = 0
	collision_mask = 0
	$AnimationPlayer.play("new_animation")

func get_color() -> Color:
	return $MeshInstance3D.mesh.material.albedo_color

func set_size(v3 :Vector3) -> Brick:
	$MeshInstance3D.mesh.size = v3
	$CollisionShape3D.shape.size = v3
	return self

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
