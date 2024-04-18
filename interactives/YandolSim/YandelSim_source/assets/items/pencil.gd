extends RigidBody2D

func _ready():get_node("/root/MainScript").pencil_collide = get_node("Area2D")

