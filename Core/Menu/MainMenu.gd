extends Control

var modes_configurator : ModesConfigurator

func _ready():
	modes_configurator = preload("res://Modes/Modes.gd").new()
	
	for modes in modes_configurator.modes:
		$GameModes.add_item(modes)
		$GameModes.select(0)

func _on_New_Game_Button_button_up():
	# Unload current scene
	var root = get_parent()
	root.remove_child(self)
	call_deferred("free")
	
	var board = preload("res://Core/Board/Board.tscn").instance()
	var selected_idx = $GameModes.get_selected_items()[0]
	var mode_name = $GameModes.get_item_text(selected_idx)
	
	board.configurator_script = load(modes_configurator.modes[mode_name])
	root.add_child(board)
