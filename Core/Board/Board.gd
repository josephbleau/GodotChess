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
var active_player

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
	active_player = loader.populate_players(self)
	loader.populate_positions(self, board_configuration)

	# Add pieces to the board according to the game mode
	configurator.run($Positions, $Players)

func move_piece(var piece, var position):
	# If we're attempting to move to the position that it is already on
	# then nothing should happen
	if piece.get_parent_position() == position:
		return
		
	# If the position we are moving to is occupied then capture the
	# piece doing the occupying
	if !position.empty():
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
		
func get_selected_piece():
	return selected_piece
	
func set_selected_piece(piece):
	selected_piece = piece
