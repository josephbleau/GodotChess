extends Node2D
signal position_selected

var neighbors = {"N": null, "S": null, "E": null, "W": null}

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
			if neighbors[movement_option] != null and neighbors[movement_option].empty():
				valid_positions.append(neighbors[movement_option])
			
	return valid_positions

func empty():
	return get_node("Piece") == null
