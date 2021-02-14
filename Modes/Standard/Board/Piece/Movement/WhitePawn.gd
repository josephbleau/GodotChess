var move_count = 0

func get_movement_options():
	if move_count == 0:
		return ["8.", "88."]
	
	return ["8."]

func get_capture_options():
	return ["7.", "9."]

func moved():
	move_count += 1
