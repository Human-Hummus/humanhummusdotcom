extends Button

func _ready():
	var main = get_node("/root/MainScript")
	pressed.connect(main.start_up)

