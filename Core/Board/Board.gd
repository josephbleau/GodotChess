extends Node

export var cols = 8
export var rows = 8

export (Color) var color
export (Color) var selected_color
export (Color) var offset_color
export (Color) var offset_selected_color

export (Script) var loader_script
export (Script) var configurator_script

var selected_piece : Piece = null
var active_player : Player = null

func _ready():
	var loader : GameLoader = loader_script.new()
	var configurator : BoardConfigurator = configurator_script.new()

	var board_configuration = {
		"rows": rows,
		"cols": cols,
		"color": color,
		"offset_color": offset_color,
		"selected_color": selected_color,
		"offset_selected_color": offset_selected_color
	}
	
	# Instantiate the scene tree with the players and all of the positions
	add_child(loader.populate_players())
	add_child(loader.populate_positions(board_configuration))

	# Add pieces to the board according to the game mode
	configurator.run($Positions, $Players)

	# Connect the position nodes on click event to our board
	for position in $Positions.get_children():
		position.connect("clicked", self, "on_position_clicked") 
	
func on_position_clicked(position):
	var piece = position.get_node("Piece")
	
	if selected_piece != null and position.is_selected():
		move_piece(selected_piece, position)
		unselect_all_positions()
	elif piece != null:
		unselect_all_positions()
		position.select_position()
		selected_piece = piece
		
		for valid_position in position.get_valid_next_position():
			valid_position.select_position()

func move_piece(var piece, var position):
	# If we're attempting to move to the position that it is already on
	# then nothing should happen
	if piece.get_parent_position() == position:
		return
		
	# If the position we are moving to is occupied then capture the
	# piece doing the occupying
	if position.has_piece():
		position.capture_piece()
	
	# Remove the piece from its curent position
	var current_parent = piece.get_parent_position()
	current_parent.remove_child(piece)
	
	# Add the piece to its new location
	piece.set_parent_position(position)
	position.add_child(piece)
	
	# Let the piece know that it has been moved
	piece.moved()

func unselect_all_positions():
	selected_piece = null
	
	for position in $Positions.get_children():
		position.unselect_position()
