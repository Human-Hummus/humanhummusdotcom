extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("CenterContainer/VBoxContainer/HBoxContainer/Button").pressed.connect(tutorial)
	get_node("CenterContainer/VBoxContainer/HBoxContainer/Button2").pressed.connect(m)

func tutorial():
	get_tree().change_scene_to_file("res://campaign.tscn")
func m():
	get_tree().change_scene_to_file("res://tutorial/main.tscn")
