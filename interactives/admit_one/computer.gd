extends Node2D

var stats
var can_press = true
func _ready() -> void:
	get_node("main/accept").pressed.connect(accept_button)
	get_node("main/reject").pressed.connect(reject_button)
	get_node("main/Check").show()
	get_node("main/X").show()
func accept_button():
	if can_press:accept()
func reject_button():
	if can_press:reject()
func accept():
	main.past_admissions.append(stats)
	can_press = false
	accept_time = 0
	get_node("main/Application").text = ""
func reject():
	get_node("main/Application").text = ""
	can_press = false
	reject_time = 0


var reject_time = 5
var accept_time = 5

func _physics_process(delta: float) -> void:
	get_node("main/Check").modulate.a = 1- (accept_time/2)
	get_node("main/X").modulate.a = 1- (reject_time/2)
	reject_time+=delta
	accept_time+=delta
	if get_node("TabBar").current_tab == 0:
		get_node("main").show()
	else:
		get_node("main").hide()
	if get_node("TabBar").current_tab == 1:
		get_node("Transcript").show()
	else:
		get_node("Transcript").hide()


func new_application(stuff):
	get_node("main/Application").text = stuff.name
	get_node("main/Application").text+=".   Born on "+str(stuff.birthday)
	get_node("main/Application").text+=".   From " +stuff.citystate
	get_node("main/Application").text+="!\nDate of Graduation: " + str(stuff.graduated)
	get_node("main/Application").text+="\nAttended: " + stuff.attended
	var classes = "Classes:\n"
	for i in stuff.classes:
		classes+=i.class_name+"   GPA: "+str(i.gpa)+"\n"
	get_node("Transcript/Label").text = classes
	print(stuff)
	stats = stuff
