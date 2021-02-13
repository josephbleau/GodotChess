extends Node


export var cols = 8
export var rows = 8

var screen_width = 512
var screen_height = 512

export (Color) var color
export (Color) var selected_color

export (Color) var offset_color
export (Color) var offset_selected_color

export (Script) var configurator

func _ready():
	var positions = Node2D.new()
	positions.name = "Positions"
	
	add_child(positions)
	
	for i in range(cols * rows):
		var position = preload("../Board/Position.tscn").instance()
		position.name = str(i)
		position.set_board(self)
		$Positions.add_child(position)
		
		
	populate_positions()
	populate_pieces()
	
func populate_positions():
	var position_width = screen_width / cols
	var position_height = screen_height / rows

	for row in range(rows):
		for col  in range(cols):
			var idx = (row * cols) + col
			var north_idx = idx - cols
			var west_idx = idx - 1
			
			var position = $Positions.get_child(idx)
						
			if (row > 0):
				position.set_neighbor("N", $Positions.get_child(north_idx))
				$Positions.get_child(north_idx).set_neighbor("S", position)
			
			if (col > 0):
				position.set_neighbor("W", $Positions.get_child(west_idx))
				$Positions.get_child(west_idx).set_neighbor("E", position)
			
			var stagger = 0
			if (row % 2 != 0):
				stagger = 1
					
			if (idx + stagger) % 2 == 0:
				position.set_colors(color, selected_color)
			else:
				position.set_colors(offset_color, offset_selected_color)
				
			position.set_size(position_width, position_height)
			position.set_position(Vector2(col * position_width, row * position_height))
				
func populate_pieces():
	configurator.new().run($Positions, get_node("/root/Game/Players"))

func unselect_all_positions():
	for position in $Positions.get_children():
		position.unselect()
