extends Node2D

export (Script) var movement_behavior_script

var player
var parent_position
var movement_behavior

func _ready():
	parent_position = get_parent()
	
	if movement_behavior_script != null:
		movement_behavior = movement_behavior_script.new()

func set_parent_position(parent_position):
	self.parent_position = parent_position
	
func get_parent_position():
	return parent_position

func get_movement_options():
	return movement_behavior.get_movement_options()

func _on_Piece_mouse_entered():
	print("Mouse entered: " + name)
