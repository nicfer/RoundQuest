extends KinematicBody2D

const GRAVITY_VEC = Vector2(0, 900)
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 25.0
const MIN_ONAIR_TIME = 0.1
const WALK_SPEED = 250 # pixels/sec
const MAX_JUMP = 50
const JUMP_SPEED = 240

var lv = Vector2()
var onair_time = 0 #
var on_floor = false
var just_jumped = false

var powerups = {"jump":{"level":6}}

#cache the sprite here for fast access (we will set scale to flip it often)
onready var sprite = $body

func add_powerup(n):
	powerups[n].level += 1

func _physics_process(delta):

	#increment counters
	onair_time += delta

	### MOVEMENT ###
	# Detect Floor
	if is_on_floor():
		onair_time = 0
		just_jumped = false

	on_floor = onair_time < MIN_ONAIR_TIME

	### CONTROL ###

	# Horizontal Movement
	var target_speed = 0
	if Input.is_action_pressed("move_left"):
		target_speed += -1
	if Input.is_action_pressed("move_right"):
		target_speed +=  1

	target_speed *= WALK_SPEED
	lv.x = lerp(lv.x, target_speed, 0.1)

	# Jumping
	var gv = GRAVITY_VEC
	if (powerups.jump.level > 0):
		if (on_floor and Input.is_action_just_pressed("move_up")):
			lv.y = -JUMP_SPEED * powerups.jump.level
			just_jumped = true

	# Apply Gravity
		if (Input.is_action_pressed("move_up")):
			gv /= 1.75 / powerups.jump.level
		elif (just_jumped):
			gv *= 2.0 * powerups.jump.level
	lv += delta * gv
	$Label.text = str(gv)
	# Move and Slide
	lv = move_and_slide(lv, FLOOR_NORMAL, SLOPE_SLIDE_STOP)

	$cam.check_scroll(position,lv)
	rotate(lv.x * 0.0005)

	collision_mask = 3 + int(lv.y > 0) * 6
	collision_layer = 3 + int(lv.y > 0) * 6
