class_name Piece extends Node2D

export (Script) var movement_behavior_script

var player
var parent_position
var movement_behavior

func _ready():
	parent_position = get_parent()
	
	if movement_behavior_script != null:
		movement_behavior = movement_behavior_script.new()

func moved():
	movement_behavior.moved()

func same_team(var piece):
	return self.player == piece.player

func set_parent_position(new_parent_position):
	parent_position = new_parent_position
	
func get_parent_position():
	return parent_position

func get_movement_options():
	return movement_behavior.get_movement_options()
	
func get_capture_options():
	return movement_behavior.get_capture_options()
