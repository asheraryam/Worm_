extends Sprite
var mobil
var loaded
var in_range
signal shoot
func construct(place,mob,rel):
	connect("shoot",get_parent().get_parent(),"on_fire")
	$reload.wait_time=rel
	$reload.start()
	mobil=mob
	position=place
func _process(delta):
	var target=get_global_mouse_position()
	if Input.is_action_pressed("ui_end"):
		if loaded and in_range and not $pivot/RayCast2D.get_collider() in get_parent().get_parent().body and abs((target-global_position).angle_to(Vector2(1,0).rotated(global_rotation)))<.5:
			emit_signal("shoot",$pivot.global_position,global_rotation)
			loaded=false
			$reload.start()
	if abs((target-global_position).angle_to(position.rotated(get_parent().rotation)))<mobil:
		global_rotation=Vector2(1,0).rotated(global_rotation).linear_interpolate((target-global_position).normalized(),10*delta).angle()
		in_range=true
	else:
		global_rotation=Vector2(1,0).rotated(global_rotation).linear_interpolate(position.normalized().rotated(get_parent().rotation),10*delta).angle()
		in_range=false
func _on_reload_timeout():
	loaded=true
	
