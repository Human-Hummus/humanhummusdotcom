extends RigidBody2D

func _ready():
	get_node("AnimatedSprite2D").play()
	get_node("/root/MainScript").bully_collide = get_node("Area2D")
