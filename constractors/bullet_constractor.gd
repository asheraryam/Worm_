extends Area2D
export (int) var speed
var done
func start(pos,dir):
	global_position=pos
	rotation=dir
	done=true
func _process(delta):
	if done:
		global_position+=Vector2(speed,0).rotated(rotation)*delta