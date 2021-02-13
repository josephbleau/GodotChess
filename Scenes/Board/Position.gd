extends Node2D

var neighbors = {}

func set_neighbor(direction, position):
	neighbors[direction] = position
	
func set_color(color):
	$Background.color = color

func set_size(width, height):
	$Background.rect_size = Vector2(width, height)
