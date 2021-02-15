class_name StandardBoard extends BoardConfigurator

var piece_templates = {
	"WP": preload("./Piece/WhitePawn.tscn"),
	"WR": preload("./Piece/WhiteRook.tscn"),
	"WN": preload("./Piece/WhiteKnight.tscn"),
	"WB": preload("./Piece/WhiteBishop.tscn"),
	"WK": preload("./Piece/WhiteKing.tscn"),
	"WQ": preload("./Piece/WhiteQueen.tscn"),
	
	"BP": preload("./Piece/BlackPawn.tscn"),
	"BR": preload("./Piece/BlackRook.tscn"),
	"BN": preload("./Piece/BlackKnight.tscn"),
	"BB": preload("./Piece/BlackBishop.tscn"),
	"BK": preload("./Piece/BlackKing.tscn"),
	"BQ": preload("./Piece/BlackQueen.tscn")
}

var configuration = [
	{
		"node": 0,
		"starting_positions": {
			0: "BR",  1: "BN",  2: "BB",  3: "BQ",  4: "BK",  5: "BB",  6: "BN",  7: "BR",
			8: "BP",  9: "BP", 10: "BP", 11: "BP", 12: "BP", 13: "BP", 14: "BP", 15: "BP",
		}
	}, 
	{
		"node": 1,
		"starting_positions": {
			48: "WP", 49: "WP", 50: "WP", 51: "WP", 52: "WP", 53: "WP", 54: "WP", 55: "WP",
			56: "WR", 57: "WN", 58: "WB", 59: "WQ", 60: "WK", 61: "WB", 62: "WN", 63: "WR"
		}
	}
]

func run(positions_node, players_node):
	for player in configuration:
		var player_node = players_node.get_child(player.node)
		
		for position in player.starting_positions:
			var piece = piece_templates[player.starting_positions[position]].instance()
			piece.player = player_node
			positions_node.get_child(position).add_child(piece)
