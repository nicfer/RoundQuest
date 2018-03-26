extends Node2D
export var mhealth = 1
export var mflashtime = 3

var health = 0
var flashtime = -1
var dead = false

func stomped():
	health += 1
	if (health < mhealth):
		flashtime = mflashtime * 4
	else:
		dead = true

func _process(delta):
	if (dead):
		modulate.a -= 0.01
		if (modulate.a <= 0.0):
			queue_free()
	if (flashtime >= 0):
		flashtime -= 1
		if (flashtime < 0):
			$stompable.set_collision_mask_bit(3,1)
			$stompable.set_collision_layer_bit(3,1)
		elif (flashtime % 4 < 2):
			$body.set_flashing(Color(0,0,0,1))
		else:
			$body.set_flashing(Color(1,1,1,1))
