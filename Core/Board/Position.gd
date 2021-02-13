extends Node2D
signal position_selected

var neighbors = {
	"1": null, "3": null, "5": self, "7": null, "9": null,
	"2": null, "4": null, "6": null, "8": null,
}

var color : Color
var selected_color : Color

var board

func set_board(board):
	self.board = board

func set_neighbor(direction, position):
	neighbors[direction] = position
	
func set_colors(color, selected_color):
	self.color = color
	self.selected_color = selected_color
	
	$Background.color = color

func set_size(width, height):
	$Background.rect_size = Vector2(width, height)
	
func position_clicked(event):
	if $Piece != null:
		if event is InputEventMouseButton and !event.pressed:
			board.unselect_all_positions()
			self.select()
			
			for valid_position in get_valid_next_position():
				valid_position.select()
	
func select():
	$Background.color = selected_color
	
func unselect():
	$Background.color = color

func get_valid_next_position():
	var valid_positions = []
	var movement_options = $Piece.get_movement_options()
	
	if movement_options != null and len(movement_options) > 0:
		for movement_option in movement_options:
			var potential_positions = parse_movement_option(movement_option)
			
			if (potential_positions != null and len(potential_positions) > 0):
				valid_positions += potential_positions
			
	return valid_positions

func empty():
	return get_node("Piece") == null

func parse_movement_option(movement_option):
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
					movement_options.append(current_position)
			"+":
				if (last_direction != null):
					while(new_position != null):
						movement_options.append(new_position)
						new_position = step(new_position, last_direction)
						current_position = new_position
							
	return movement_options

func step(position, direction):
	return position.neighbors[direction]
