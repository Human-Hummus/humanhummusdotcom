extends Node2D



func _ready():
	var main = get_node("/root/MainScript")
	main.coffee_collide = get_node("Area2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
