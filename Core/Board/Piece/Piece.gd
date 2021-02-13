extends Node2D

export (Script) var movement_behavior_script

var player
var movement_behavior

func _ready():
	if movement_behavior_script != null:
		movement_behavior = movement_behavior_script.new()

func get_movement_options():
	return movement_behavior.get_movement_options()

func _on_Piece_mouse_entered():
	print("Mouse entered: " + name)
