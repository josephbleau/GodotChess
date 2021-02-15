class_name GameLoader

var screen_width = 512
var screen_height = 512

func populate_players(var board):
	var players = Node.new()
	var player1 = preload("./Player/Player.tscn").instance()
	var player2 = preload("./Player/Player.tscn").instance()
	
	players.name = "Players"
	player1.name = "Player1"
	player2.name = "Player2"
	
	board.add_child(players)
	board.get_node("Players").add_child(player1)
	board.get_node("Players").add_child(player2)

	return player1

func instantiate_positions(var board, var cols, var rows):
	var positions = Node2D.new()
	positions.name = "Positions"
	
	board.add_child(positions)
	
	for i in range(cols * rows):
		var position = preload("./Board/Position.tscn").instance()
		position.name = str(i)
		position.set_board(board)
		board.get_node("Positions").add_child(position)

	return positions

func populate_positions(var board, var board_configuration):
	var cols = board_configuration.cols
	var rows = board_configuration.rows
	var position_width = screen_width / cols
	var position_height = screen_height / rows

	var positions = instantiate_positions(board,cols, rows)

	for row in range(rows):
		for col  in range(cols):
			var idx = (row * cols) + col
			var north_idx = idx - cols
			var west_idx = idx - 1
			
			var position = positions.get_child(idx)
						
			if (row > 0):
				position.set_neighbor("8", positions.get_child(north_idx))
				positions.get_child(north_idx).set_neighbor("2", position)
				
				if (col > 0):
					position.set_neighbor("7", positions.get_child(north_idx - 1))
					positions.get_child(north_idx - 1).set_neighbor("3", position)
				
				if (col < cols-1):
					position.set_neighbor("9", positions.get_child(north_idx + 1))
					positions.get_child(north_idx + 1).set_neighbor("1", position)
				
			
			if (col > 0):
				position.set_neighbor("4", positions.get_child(west_idx))
				positions.get_child(west_idx).set_neighbor("6", position)
			
			var stagger = 0
			if (row % 2 != 0):
				stagger = 1
					
			if (idx + stagger) % 2 == 0:
				position.set_colors(board_configuration.color, board_configuration.selected_color)
			else:
				position.set_colors(board_configuration.offset_color, board_configuration.offset_selected_color)
				
			position.set_size(position_width, position_height)
			position.set_position(Vector2(col * position_width, row * position_height))
