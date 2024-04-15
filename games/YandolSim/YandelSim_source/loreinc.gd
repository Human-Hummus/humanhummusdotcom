extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/MainScript").loreinc_collide = get_node("Area2D")
