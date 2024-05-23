extends Node2D

var main = null
# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_node("/root/MainScript")
	get_node("Button").pressed.connect(on_pressed_button)

func on_pressed_button():
	
