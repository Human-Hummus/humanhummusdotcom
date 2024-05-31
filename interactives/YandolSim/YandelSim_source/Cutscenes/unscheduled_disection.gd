extends Node2D

func _ready():
	if !get_node("/root/MainScript").persistant_data.acheivements.contains("Unscheduled Disection"):
		get_node("/root/MainScript").persistant_data.acheivements+="Unscheduled Disection"
