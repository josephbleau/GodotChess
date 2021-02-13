extends Node2D

export (Script) var movement_behavior

var player

func get_movement_options():
	movement_behavior.get_movement_options()

func _on_Piece_mouse_entered():
	print("Mouse entered: " + name)
