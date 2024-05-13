extends RigidBody2D

func _ready():
	get_node("AnimatedSprite2D").play()
	var main = get_node("/root/MainScript")
	main.vicdraweria_collide = get_node("Area2D")
