extends RigidBody2D
var speed = 5
var jump_power = 1
var jump_inertia = 0
var jumping = 0
var powerups = {"jump":{"level":13}}

func add_powerup(n):
	if (powerups.has(n)):
		powerups[n].level += 1
	else:
		powerups[n] = {"level":1}

func add_impulse(i):
	var off = $body.texture.get_size() * i.normalized() * -1
	apply_impulse(off,i)

func _physics_process(delta):
	var impulse = Vector2(0,0)
	if (Input.is_action_pressed("move_right")):
		impulse.x = speed
	elif (Input.is_action_pressed("move_left")):
		impulse.x = -speed
		#apply_impulse(Vector2(speed,0),Vector2(-speed,0))
	if (jumping == 0 and Input.is_action_pressed("move_up")\
			and powerups.has("jump")):
		jumping = 1
		gravity_scale = 0
		jump_inertia = powerups.jump.level
		impulse.y = -speed
	if (jumping == 1):
		jump_inertia -= 1
		if (jump_inertia <= 0 or !Input.is_action_pressed("move_up")):
			jumping = 2
			gravity_scale = 1
		else:
			impulse.y = -jump_inertia
	elif (jumping == 2):
		if (linear_velocity.y == 0.0):
			jumping = 0
	#estados: 0=on_floor; 1=jumping;2=stopped_jump
	add_impulse(impulse)
	$Label.text = str(global_position)#linear_velocity)
	$cam.check_scroll(position,linear_velocity)
	if (linear_velocity.y > 0):
		set_collision_layer_bit(3,1)
		set_collision_mask_bit(3,1)
		set_collision_layer_bit(1,0)
		set_collision_mask_bit(1,0)
	else:
		set_collision_layer_bit(3,0)
		set_collision_mask_bit(3,0)
		set_collision_layer_bit(1,1)
		set_collision_mask_bit(1,1)
#	if (position.y > 456):
#		$Camera2D.limit_bottom = position.y + 96
