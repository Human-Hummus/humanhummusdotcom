extends Node2D

var main = null
# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_node("/root/MainScript")
	get_node("Button").pressed.connect(on_pressed_button)

func on_pressed_button():
	
	var save_game = FileAccess.open(main.save_file_name, FileAccess.READ)
	print(save_game)
	if save_game == null:
		return
	var json_string = save_game.get_line()

	var json = JSON.new()

	var parse_result = json.parse(json_string)
	if !parse_result == OK:
		return
	main.persistant_data = json.get_data()
