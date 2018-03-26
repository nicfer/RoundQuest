extends Camera2D

func check_scroll(p,lv):
	if (p.x >
				OS.window_size.x
			+ limit_left
		and lv.x > 0):
			limit_right += OS.window_size.x
			limit_left += OS.window_size.x
	elif (p.x <
				limit_right
			- OS.window_size.x
		and lv.x < 0):
			limit_right -= OS.window_size.x
			limit_left -= OS.window_size.x
	if (p.y >
				OS.window_size.y
			+ limit_top
		and lv.y > 0):
			limit_top += OS.window_size.y
			limit_bottom += OS.window_size.y
	elif (p.y < limit_bottom
		and lv.y < 0):
			limit_top -= OS.window_size.y
			limit_bottom -= OS.window_size.y