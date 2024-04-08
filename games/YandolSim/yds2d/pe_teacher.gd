extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/MainScript").gym_collide = get_node("Area2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
