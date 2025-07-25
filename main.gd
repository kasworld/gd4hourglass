extends Node3D

const MaxDrop = 2000
var drop_dur :float
func _ready() -> void:
	reset_camera_pos()
	drop_dur = Time.get_unix_time_from_system()

func add_drops() -> void:
	$DropContainer.add_child(rand_pos_rot(
		preload("res://ball.tscn").instantiate(
		).init(Vector3.ZERO, Vector3.ZERO
		).set_color(random_color()
		).set_radius(randfn(0.25, 0.05)
	)))
	$DropContainer.add_child(rand_pos_rot(
		preload("res://char.tscn").instantiate(
		).init(Vector3.ZERO, Vector3.ZERO
		).set_color(random_color()
		).set_height_depth( randfn(0.8, 0.1), randfn(0.1,0.01)
		).set_char(PlayingCard.Symbols.pick_random()
	)))
	$DropContainer.add_child(rand_pos_rot(
		preload("res://coin.tscn").instantiate(
		).init(Vector3.ZERO, Vector3.ZERO
		).set_color(random_color()
		).set_radius_height( randfn(0.4,0.05), randfn(0.1,0.01)
	)))
	$DropContainer.add_child(rand_pos_rot(
		preload("res://capsule.tscn").instantiate(
		).init(Vector3.ZERO, Vector3.ZERO
		).set_color(random_color()
		).set_radius_height( randfn(0.2,0.05), randfn(0.8,0.05)
	)))
	$DropContainer.add_child(rand_pos_rot(
		preload("res://dice.tscn").instantiate(
		).init(Vector3.ZERO, Vector3.ZERO
		).set_color(random_color()
		).set_size( Vector3( randfn(0.4,0.05), randfn(0.4,0.05), randfn(0.4,0.05) )
	)))

var camera_move = true
func _process(delta: float) -> void:
	update_label()
	var t = Time.get_unix_time_from_system() /-3.0
	if camera_move:
		$Camera3D.position = Vector3(sin(t)*10, sin(t)*8, cos(t)*10)
		$Camera3D.look_at(Vector3.ZERO)

func _physics_process(delta: float) -> void:
	if $DropContainer.get_child_count() < MaxDrop:
		add_drops()

func update_label() -> void:
	$"왼쪽패널/LabelTime".text = "%.2f초" % [ Time.get_unix_time_from_system() - drop_dur]
	$"왼쪽패널/LabelDrops".text = "Drops %s/%s" %[$DropContainer.get_child_count(), MaxDrop ]
	$"왼쪽패널/LabelPerformance".text = """%d FPS (%.2f mspf)
%d objects
%dK primitive indices
%d draw calls""" % [
	Engine.get_frames_per_second(),1000.0 / Engine.get_frames_per_second(),
	RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_OBJECTS_IN_FRAME),
	RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_PRIMITIVES_IN_FRAME) * 0.001,
	RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_DRAW_CALLS_IN_FRAME),
	]

func rand_pos_rot(n :Node3D) -> Node3D:
	n.position = Vector3(randf_range(-5,5),randf_range(8,9),randf_range(-5,5))
	#n.position = Vector3(0, 9, 0)
	n.rotation = Vector3(randf_range(-PI,PI),randf_range(-PI,PI),randf_range(-PI,PI))
	return n

func rand_vector3(m :float) -> Vector3:
	return Vector3(randf_range(-m,m),randf_range(-m,m),randf_range(-m,m))

func random_color() -> Color:
	return NamedColorList.color_list.pick_random()[0]

var key2fn = {
	KEY_ESCAPE:_on_button_esc_pressed,
	KEY_ENTER:_on_카메라변경_pressed,
	KEY_SPACE:_on_중력반전_pressed,
}
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var fn = key2fn.get(event.keycode)
		if fn != null:
			fn.call()
	elif event is InputEventMouseButton and event.is_pressed():
		pass

func _on_button_esc_pressed() -> void:
	get_tree().quit()

func _on_카메라변경_pressed() -> void:
	camera_move = !camera_move
	if camera_move == false:
		reset_camera_pos()

func reset_camera_pos()->void:
	$Camera3D.position = Vector3(1,10,0)
	$Camera3D.look_at(Vector3.ZERO)
	$Camera3D.far = 50

func _on_중력반전_pressed() -> void:
	var current_gravity :Vector3 = PhysicsServer3D.area_get_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY_VECTOR )
	# Set the default gravity direction to `Vector3(0, -1, 0)`.
	#PhysicsServer3D.area_set_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY_VECTOR, Vector3.DOWN)	
	PhysicsServer3D.area_set_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY_VECTOR, -current_gravity)	
	drop_dur = Time.get_unix_time_from_system()
