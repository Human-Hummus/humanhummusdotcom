extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if !get_node("/root/MainScript").persistant_data.acheivements.contains("Gradeful"):
		get_node("/root/MainScript").persistant_data.acheivements+="Gradeful"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
