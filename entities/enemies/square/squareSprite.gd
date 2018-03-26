extends Sprite
var color
var flashing = Color(0,0,0,1)

func _ready():
	color = self_modulate

func set_flashing(c):
	flashing = c
	self_modulate = color + flashing