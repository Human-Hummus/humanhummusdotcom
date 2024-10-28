extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Button").pressed.connect(function)
func function():
	get_tree().change_scene_to_file("res://intro.tscn")
