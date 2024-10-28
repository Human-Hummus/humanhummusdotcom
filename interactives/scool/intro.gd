extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Play").pressed.connect(go)
	
func go():
	Main.class_number = 0
	Main.health = 10
	get_tree().change_scene_to_file("res://fight_to_class.tscn")
