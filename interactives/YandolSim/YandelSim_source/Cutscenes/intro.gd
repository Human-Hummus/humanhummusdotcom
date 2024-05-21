extends Node2D

var main = null
# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_node("/root/MainScript")
	get_node("Button").pressed.connect(go_to_main)
	get_node("mobilemode").pressed.connect(flip_mobile)
	

func go_to_main():
	main.start_up()
	

func flip_mobile():
	var btn = get_node("mobilemode")
	main.is_mobile = !main.is_mobile
	if main.is_mobile:
		btn.text = "disable\nmobile mode"
	else:
		btn.text = "enable\nmobile mode"
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print("boobies: " + str(get_node("mobilemode").toggle_mode))
