extends Position2D
var body=[]
var heading=0
var vel=Vector2()

export (PackedScene) var camera
#body settings
export (int) var base=64
export (int) var segment_number=10
export (float) var turning=1
export (int) var max_speed=500
export (int) var min_speed=200
export (int) var acceleration=50
export (PackedScene) var Segment
#turret settings
export (int) var weapon_tipe=2
export (PackedScene) var weapon
export (float) var turret_mobility=PI/3
export (float) var reload=.5
#bullet settings
export (PackedScene) var Bullet

func _ready():
	randomize()
	var weapon_peck=[weapon,weapon_tipe,turret_mobility,reload]
	var j1=position
	for i in range(segment_number):
		var segment=Segment.instance()
		add_child(segment)
		body.append(segment)
		segment.construct(j1,weapon_peck,base,i)
		move_child(segment,0)
		j1=j1-Vector2(base,0)
		base=-base
func _process(delta):
	control(delta)
	if vel.length()>max_speed:
		vel=Vector2(max_speed,0)
	if vel:
		var vel_=vel.rotated(heading)*delta
		for segment in body :
			vel_=Vector2(vel_.length(),0).rotated((segment.j1-segment.j2).angle_to(vel_))
			segment.move(vel_)
			vel_=Vector2(segment.base+vel_.x-sqrt(segment.base*segment.base-vel_.y*vel_.y),0).rotated(segment.rotation)
func on_fire(pos,rot):
	if Bullet:
		var b=Bullet.instance()
		add_child(b)
		b.start(pos,rot)
func control(delta):
#	pass
	var acc=Vector2()
	if Input.is_action_pressed("ui_up"):
		acc=Vector2(acceleration,0)
	if Input.is_action_pressed("ui_left") and vel.length()>min_speed:
		heading-=PI*delta*turning
	elif Input.is_action_pressed("ui_right") and vel.length()>min_speed:
		heading+=PI*delta*turning
	vel+=acc-vel*0.04
