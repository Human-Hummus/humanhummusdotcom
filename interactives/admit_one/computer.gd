extends Node2D

var stats
var can_press = true
func _ready() -> void:
	get_node("accept").pressed.connect(accept_button)
	get_node("reject").pressed.connect(reject_button)
	get_node("Check").show()
	get_node("X").show()
func accept_button():
	if can_press:accept()
func reject_button():
	if can_press:reject()
func accept():
	main.past_admissions.append(stats)
	can_press = false
	accept_time = 0
	get_node("Application").text = ""
func reject():
	get_node("Application").text = ""
	can_press = false
	reject_time = 0


var reject_time = 5
var accept_time = 5

func _physics_process(delta: float) -> void:
	get_node("Check").modulate.a = 1- (accept_time/2)
	get_node("X").modulate.a = 1- (reject_time/2)
	reject_time+=delta
	accept_time+=delta

func new_application(stuff):
	get_node("Application").text = stuff.name
	get_node("Application").text+=".   Born on "+str(stuff.birthday)
	get_node("Application").text+=".   From " +stuff.citystate
	get_node("Application").text+="!\nDate of Graduation: " + str(stuff.graduated)
	get_node("Application").text+="\nAttended: " + stuff.attended
	get_node("Application").text+="\nGPA in Science: "+str(stuff.sci_gpa)
	get_node("Application").text+="\nGPA in Social Studies: "+str(stuff.social_gpa)
	get_node("Application").text+="\nGPA in English Language Arts: "+str(stuff.ela_gpa)
	get_node("Application").text+="\nGPA in Math: "+str(stuff.math_gpa)
	print(stuff)
	stats = stuff
