var move_count = 0

func get_movement_options():
	if move_count == 0:
		return ["2.", "22."]
	
	return ["2."]
	
func get_capture_options():
	return ["1.", "3."]

func moved():
	move_count += 1
