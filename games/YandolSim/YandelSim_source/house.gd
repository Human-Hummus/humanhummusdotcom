extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var main = get_node("/root/MainScript")
	main.road2_collide = get_node("road")
	main.bed_collide = get_node("bed")
