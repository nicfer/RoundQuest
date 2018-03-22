extends RigidBody2D
var speed = 5
var jump_power = 15
var jump_inertia = 0
var jumping = 0
var powerups = []

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
		jump_inertia = jump_power
		impulse.y = -speed
	if (jumping == 1):
		jump_inertia -= 1
		if (jump_inertia <= 0 or !Input.is_action_pressed("move_up")):
			jumping = 2
		else:
			impulse.y = -jump_inertia
	elif (jumping == 2):
		if (linear_velocity.y == 0.0):
			jumping = 0
	#estados: 0=on_floor; 1=jumping;2=stopped_jump
	apply_impulse(-impulse,impulse)
	$Label.text = str(global_position)
	if (position.y > 456):
		$Camera2D.limit_bottom = position.y + 96
