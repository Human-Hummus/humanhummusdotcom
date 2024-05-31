extends Button

func _ready():
	var main = get_node("/root/MainScript")
	pressed.connect(todo)
func todo():
	get_tree().change_scene_to_file("res://Cutscenes/intro.tscn")
