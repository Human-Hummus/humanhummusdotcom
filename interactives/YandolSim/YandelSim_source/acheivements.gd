extends Node2D

func _physics_process(delta):
	var main = get_node("/root/MainScript")
	if !main.persistant_data.acheivements.contains("Aviator Ending"):
		get_node("ItemList/aviator ending").hide()
	else:
		get_node("ItemList/aviator ending").show()
