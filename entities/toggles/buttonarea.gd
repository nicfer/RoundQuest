extends Area2D

func _on_Area2D_body_entered( body ):
	if (get_parent().frame == 0 and body is preload("res://player/player.gd")):
		get_parent().frame = 1
#	for t in $"../toggles".get_children():
	if (get_parent().toggle_group != ""):
		for t in get_tree().get_nodes_in_group(
			"toggle_" + get_parent().toggle_group
		):
			t.toggle()
