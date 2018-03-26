extends Area2D
var hit = false
var health = 0
var flashtime = 0

func _process(delta):
	if (health >= get_parent().mhealth):
		get_parent().modulate.a -= 0.01
		if (get_parent().modulate.a <= 0.0):
			get_parent().queue_free()

func _on_stompable_body_entered( body ):
	if (body is preload("res://player/player.gd")):
		body.add_impulse(Vector2(0,body.linear_velocity.y*-2))
		collision_mask = 0
		collision_layer = 0
		get_parent().stomped()
