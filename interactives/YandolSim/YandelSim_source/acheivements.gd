extends Node2D

func _physics_process(delta):
	var main = get_node("/root/MainScript")
	if !main.persistant_data.acheivements.contains("Aviator Ending"):
		get_node("ItemList/aviator ending").hide()
	else:
		get_node("ItemList/aviator ending").show()
	if !main.persistant_data.acheivements.contains("Heart Attack"):
		get_node("ItemList/Coffee").hide()
	else:
		get_node("ItemList/Coffee").show()
	if !main.persistant_data.acheivements.contains("Gradeful"):
		get_node("ItemList/Grade").hide()
	else:
		get_node("ItemList/Grade").show()
	if !main.persistant_data.acheivements.contains("Unscheduled Disection"):
		get_node("ItemList/Disected").hide()
	else:
		get_node("ItemList/Disected").show()
