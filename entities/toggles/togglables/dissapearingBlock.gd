extends Node
export var posx = 0
export var posy = 0
export var sequence = "-1,2"

func _ready():
	get_parent().add_block(posx,posy,sequence)
