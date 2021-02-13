extends Node

var active_player

func _ready():
	var board = preload("res://Scenes/Board/Board.tscn").instance()
	var player1 = preload("res://Scenes/Player/Player.tscn").instance()
	var player2 = preload("res://Scenes/Player/Player.tscn").instance()
	var players = Node.new()
	
	players.name = "Players"
	player1.name = "Player1"
	player2.name = "Player2"
	
	add_child(players)	
	$Players.add_child(player1)
	$Players.add_child(player2)
	
	add_child(board)
		
	active_player = player1
