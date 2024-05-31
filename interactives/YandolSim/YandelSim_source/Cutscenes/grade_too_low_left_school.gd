extends Node2D

func _ready():
	if !get_node("/root/MainScript").persistant_data.acheivements.contains("Gradeful"):
		get_node("/root/MainScript").persistant_data.acheivements+="Gradeful"

