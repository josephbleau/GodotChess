extends Node2D
signal clicked

var neighbors = {
	"1": null, "3": null, "5": self, "7": null, "9": null,
	"2": null, "4": null, "6": null, "8": null,
}

var color : Color
var selected_color : Color
var selected : bool = false

func set_neighbor(direction, position):
	neighbors[direction] = position
	
func set_colors(new_color, new_selected_color):
	color = new_color
	selected_color = new_selected_color
	$Background.color = color

func set_size(width, height):
	$Background.rect_size = Vector2(width, height)
	
func position_clicked(event):
	if event is InputEventMouseButton and !event.pressed:
		emit_signal("clicked", self)
		
func is_selected():
	return selected
		
func select_position():
	$Background.color = selected_color
	selected = true
	
func unselect_position():
	$Background.color = color
	selected = false

func has_piece():
	return get_node("Piece") != null

func get_valid_next_position():
	var valid_positions = []
	var movement_options = $Piece.get_movement_options()
	var capture_options = $Piece.get_capture_options()
	
	for movement_option in movement_options:
		var potential_positions = parse_movement_option(movement_option, false)
			
		if (potential_positions != null and len(potential_positions) > 0):
			valid_positions += potential_positions
			
	for capture_option in capture_options:
		var potential_positions = parse_movement_option(capture_option, true)
			
		if (potential_positions != null and len(potential_positions) > 0):
			valid_positions += potential_positions
	
	return valid_positions

func parse_movement_option(movement_option, capture):
	var current_position = self
	var movement_options = []
	
	var last_direction = null
	var new_position = null
	
	for symbol in movement_option:
		if(current_position == null):
			break
			
		match symbol:
			"1","2","3","4","5","6","7","8","9":
				new_position = step(current_position, symbol)
				last_direction = symbol
				current_position = new_position
			".":
				if (current_position != null):
					if !capture and !current_position.has_piece():
						movement_options.append(current_position) 
					elif (capture and current_position.has_piece()):
						if !current_position.same_team($Piece):
							movement_options.append(current_position)
			"+":
				if (last_direction != null):
					while(new_position != null):
						if !new_position.has_piece():
							movement_options.append(new_position)
						else:
							var same_team = new_position.same_team($Piece)
							if capture and !same_team:
								movement_options.append(new_position)
							break
						
						new_position = step(new_position, last_direction)
						current_position = new_position
						
	return movement_options

func step(position, direction):
	return position.neighbors[direction]
	
func same_team(var piece):
	return $Piece.same_team(piece)
	
func capture_piece():
	var piece = get_node("Piece")
	
	if piece != null:
		remove_child(piece)
