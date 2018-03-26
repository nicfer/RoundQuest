extends Area2D

func _on_powerup_body_entered( body ):
	if (body is preload("res://player/player.gd")):
		body.add_powerup(name)
		queue_free()
