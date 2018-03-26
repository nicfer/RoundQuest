extends Node
export var speed = 60

var blocks = []
var timer = -1

func toggle():
	timer = 0

func add_block(x,y,sequence):
	var seq = []
	for s in sequence.split(","):
		seq.append(int(s))
	blocks.append({"x":x,"y":y,"sequence":seq,"seqpos":0})

func _process(delta):
	if (timer >= 0 and blocks.size() > 0):
		timer += 1
		if (timer > speed):
			timer = 0
			for b in blocks:
				b.seqpos = (b.seqpos + 1) % b.sequence.size()
				get_parent().set_cell(b.x,b.y,b.sequence[b.seqpos])