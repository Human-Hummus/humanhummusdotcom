extends Node2D
func _ready() -> void:
	get_node("CenterContainer/Button").pressed.connect(go_to_tutorial)
	
func go_to_tutorial():
	get_tree().change_scene_to_file("res://tutorial/main.tscn")
