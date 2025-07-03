extends Node3D

const MaxDrop = 10000
var deck 
func _ready() -> void:
	var vp_size = get_viewport().get_visible_rect().size
	var 짧은길이 = min(vp_size.x,vp_size.y)
	$"왼쪽패널".size = Vector2(vp_size.x/2 - 짧은길이/2, vp_size.y)

	reset_camera_pos()

	deck = PlayingCard.make_deck_with_joker()

var camera_move = true
func _process(delta: float) -> void:
	if $DropContainer.get_child_count() < MaxDrop:
		$DropContainer.add_child(rand_pos_rot(
			preload("res://ball.tscn").instantiate(
			).init(Vector3.ZERO, Vector3.ZERO
			).set_color(random_color()
			).set_radius(0.3
		)))
		$DropContainer.add_child(rand_pos_rot(
			preload("res://char.tscn").instantiate(
			).init(Vector3.ZERO, Vector3.ZERO
			).set_char(deck.pick_random()
			).set_color(random_color()
			).set_height_depth(1,0.1
		)))
	update_label()
	var t = Time.get_unix_time_from_system() /-3.0
	if camera_move:
		$Camera3D.position = Vector3(sin(t)*10, sin(t)*5+5, cos(t)*10)
		$Camera3D.look_at(Vector3.ZERO)

func update_label() -> void:
	$"왼쪽패널/Label".text = "%s/%s" %[$DropContainer.get_child_count(), MaxDrop ]

func rand_pos_rot(n :Node3D) -> Node3D:
	n.position = Vector3(randf_range(-1,1),randf_range(7,9),randf_range(-1,1))
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
