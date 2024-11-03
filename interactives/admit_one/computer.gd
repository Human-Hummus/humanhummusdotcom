extends Node2D

var stats
var can_press = true
func _ready() -> void:
	get_node("accept").pressed.connect(accept_button)
	get_node("reject").pressed.connect(reject_button)
func accept_button():
	if can_press:accept()
func reject_button():
	if can_press:reject()
func accept():
	main.past_admissions.append(stats)
	can_press = false
	get_node("Application").text = ""
	get_node("Stats").text = ""
func reject():
	get_node("Application").text = ""
	get_node("Stats").text = ""
	can_press = false


func _process(delta: float) -> void:
	pass

func new_application(stuff):
	get_node("Application").text = stuff["text"]
	get_node("Stats").text = "Name: " + str(stuff["name"]) + "\nGPA: " + str(stuff["gpa"])+ "\nSAT Score: " + str(stuff["sat"]) + "\nAwards: " + stuff["awards"]
	print(stuff)
	stats = stuff
