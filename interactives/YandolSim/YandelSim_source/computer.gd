extends Node2D


func _ready():
	var main = get_node("/root/MainScript")
	var shutdown_button = get_node("shutdown")
	shutdown_button.pressed.connect(shutdown)
	
func shutdown():
	get_tree().change_scene_to_file("res://main.tscn")
