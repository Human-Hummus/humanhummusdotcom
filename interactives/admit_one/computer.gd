extends Node2D


func gpa_of(list):
	var toret = 2.0
	for i in list:
		toret += i
		toret/=2
	return toret

func update_website():
	var admissions = main.past_admissions
	get_node("Website/Students").text = "Student population: " + str(len(admissions))
	var chemistry = []
	var biology = []
	var math = []
	var physics = []
	var english = []
	var history = []
	for admission in admissions:
		for cl in admission.classes:
			if cl.subject == "Chemistry":chemistry.append(cl.gpa)
			if cl.subject == "Biology":biology.append(cl.gpa)
			if cl.subject == "Math":math.append(cl.gpa)
			if cl.subject == "Physics":physics.append(cl.gpa)
			if cl.subject == "English":english.append(cl.gpa)
			if cl.subject == "History":history.append(cl.gpa)
	get_node("Website/Chemistry GPA").text = "Chemistry GPA: " + str(main.round_to_dec(gpa_of(chemistry),1))
	get_node("Website/Biology GPA").text = "Biology GPA: " + str(main.round_to_dec(gpa_of(biology),1))
	get_node("Website/Math GPA").text = "Math GPA: " + str(main.round_to_dec(gpa_of(math),1))
	get_node("Website/Physics GPA").text = "Physics GPA: " + str(main.round_to_dec(gpa_of(physics),1))
	get_node("Website/English GPA").text = "English GPA: " + str(main.round_to_dec(gpa_of(english),1))
	get_node("Website/History GPA").text = "History GPA: " + str(main.round_to_dec(gpa_of(history),1))

var stats
var can_press = false
func _ready() -> void:
	get_node("main/accept").pressed.connect(accept_button)
	get_node("main/reject").pressed.connect(reject_button)
	get_node("main/Check").show()
	get_node("main/X").show()
	update_website()
func accept_button():
	if can_press:accept()
func reject_button():
	if can_press:reject()
func accept():
	main.past_admissions.append(stats)
	can_press = false
	accept_time = 0
	get_node("main/Application").text = ""
	update_website()
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
	if get_node("TabBar").current_tab == 2:
		get_node("Website").show()
	else:
		get_node("Website").hide()


func new_application(stuff):
	get_node("main/Application").text = stuff.name
	get_node("main/Application").text+=".   Born on "+str(stuff.birthday)
	get_node("main/Application").text+=".   From " +stuff.citystate
	get_node("main/Application").text+="!\nDate of Graduation: " + str(stuff.graduated)
	get_node("main/Application").text+="\nAttended: " + stuff.attended
	var classes = "Classes:\n"
	for i in stuff.classes:
		classes+=i.class_name+"     Grade: "+str(i.gpa)+"\n"
	get_node("Transcript/Label").text = classes
	stats = stuff
