extends Area2D
var j1
var j2
var base
var guns=[]
func construct(_j1,wp,_base,i):
	j1=_j1
	base=abs(_base)
	j2=_j1-Vector2(_base,0)
	if i==0 or i==get_parent().segment_number:
		if i==0:
			$image2.hide()
		if wp[0] and wp[1]==2:
			weaponise(wp[0],wp[1],wp[2],wp[3])
	elif wp[0]:
		weaponise(wp[0],wp[1],wp[2],wp[3])
func weaponise(weapon,type,mobility,reload):
	var place=$image.get_rect().size.y/2 
	var st_rt=PI/2
	if type==1:
		pass
	if type==2:
		for i in range(type):
			var w=weapon.instance()
			add_child(w)
			w.construct(Vector2(0,place),mobility,reload)
			place=-place
func move(vel):
	var rot=(j1-j2).angle()
	global_position=j1+(j2-j1)/2
	rotation=rot
	$image2.global_position=j1
	j1+=vel.rotated(rot)
	j2+=Vector2(vel.x+base-sqrt(base*base-vel.y*vel.y),0).rotated(rot)
	new()
func new():
	pass
	
	