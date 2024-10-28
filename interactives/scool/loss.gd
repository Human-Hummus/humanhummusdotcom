extends Node2D

func _ready():
	get_node("Ded/Button").pressed.connect(goto)

func goto():get_tree().change_scene_to_file("res://intro.tscn")
