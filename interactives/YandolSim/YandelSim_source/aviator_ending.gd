extends Node2D

func _ready():
	if !get_node("/root/MainScript").persistant_data.acheivements.contains("Aviator Ending"):
		get_node("/root/MainScript").persistant_data.acheivements+="Aviator Ending"
