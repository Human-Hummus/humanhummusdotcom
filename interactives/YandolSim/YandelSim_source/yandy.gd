extends CharacterBody2D
func _ready():get_node("/root/MainScript").yandy_collide = get_node("Area2D")
