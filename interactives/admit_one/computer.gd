extends Node2D

var ac = false
func gpa_of(list):
	var toret = 2.0
	for i in list:
		toret += i
		toret/=2
	return toret


var website_edit_mode = false
func update_website():
	
	print(website_edit_mode)
	var admissions = main.past_admissions
	get_node("Website/gpas_and_stuff/students/Students").text = "Student population: " + str(len(admissions))
	var chemistry = []
	var biology = []
	var math = []
	var physics = []
	var english = []
	var history = []
	var race_tally = {
		"WT":0,
		"AS":0,
		"ME":0,
		"BL":0,
		"AI":0,
		"HS":0	
	}
	var gender_tally = {
		"male":0,
		"female":0,
		"non_binary":0,
		"intersex":0,
	}
 
	for admission in admissions:
		
		if admission.race == main.race.WT: race_tally.WT+=1
		if admission.race == main.race.AS: race_tally.AS+=1
		if admission.race == main.race.ME: race_tally.ME+=1
		if admission.race == main.race.BL: race_tally.BL+=1
		if admission.race == main.race.AI: race_tally.AI+=1
		if admission.race == main.race.HS: race_tally.HS+=1
		if admission.gender == "male": gender_tally.male+=1
		if admission.gender == "female": gender_tally.female+=1
		if admission.gender == "intersex": gender_tally.intersex+=1
		if admission.gender == "non-binary": gender_tally.non_binary+=1
		for cl in admission.classes:
			if cl.subject == "Chemistry":chemistry.append(cl.gpa)
			if cl.subject == "Biology":biology.append(cl.gpa)
			if cl.subject == "Math":math.append(cl.gpa)
			if cl.subject == "Physics":physics.append(cl.gpa)
			if cl.subject == "English":english.append(cl.gpa)
			if cl.subject == "History":history.append(cl.gpa)
	var lpa = len(main.past_admissions)
	if lpa == 0:lpa=1
	var items_to_do = [
		get_node("Website/gpas_and_stuff/students"),
		get_node("Website/gpas_and_stuff/physics"),
		get_node("Website/gpas_and_stuff/history"),
		get_node("Website/gpas_and_stuff/english"),
		get_node("Website/gpas_and_stuff/math"),
		get_node("Website/gpas_and_stuff/bio"),
		get_node("Website/gpas_and_stuff/chemistry")]
	if website_edit_mode:
		for x in items_to_do:
			for y in x.get_children():
				y.show()
			x.show()
	else:
		for x in items_to_do:
			var is_enabled = x.get_node("CheckBox").button_pressed
			print(is_enabled)
			x.get_node("CheckBox").hide()
			if is_enabled:
				x.show()
			else:
				x.hide()
			
	get_node("Website/gpas_and_stuff/chemistry/Chemistry GPA").text = "Chemistry GPA: " + str(main.round_to_dec(gpa_of(chemistry),1))
	get_node("Website/gpas_and_stuff/bio/Biology GPA").text = "Biology GPA: " + str(main.round_to_dec(gpa_of(biology),1))
	get_node("Website/gpas_and_stuff/math/Math GPA").text = "Math GPA: " + str(main.round_to_dec(gpa_of(math),1))
	get_node("Website/gpas_and_stuff/physics/Physics GPA").text = "Physics GPA: " + str(main.round_to_dec(gpa_of(physics),1))
	get_node("Website/gpas_and_stuff/english/English GPA").text = "English GPA: " + str(main.round_to_dec(gpa_of(english),1))
	get_node("Website/gpas_and_stuff/history/History GPA").text = "History GPA: " + str(main.round_to_dec(gpa_of(history),1))
	get_node("Website/Demographics/WT").text = str((race_tally.WT*100/lpa)) + "% " + main.race_text(main.race.WT)
	get_node("Website/Demographics/AS").text = str((race_tally.AS*100/lpa)) + "% " + main.race_text(main.race.AS)
	get_node("Website/Demographics/ME").text = str((race_tally.ME*100/lpa)) + "% " + main.race_text(main.race.ME)
	get_node("Website/Demographics/BL").text = str((race_tally.BL*100/lpa)) + "% " + main.race_text(main.race.BL)
	get_node("Website/Demographics/AI").text = str((race_tally.AI*100/lpa)) + "% " + main.race_text(main.race.AI)
	get_node("Website/Demographics/HS").text = str((race_tally.HS*100/lpa)) + "% " + main.race_text(main.race.HS)
	get_node("Website/Demographics/male").text = str((gender_tally.male*100/lpa)) + "% Male"
	get_node("Website/Demographics/female").text = str((gender_tally.female*100/lpa)) + "% Female"
	get_node("Website/Demographics/non-binary").text = str((gender_tally.non_binary*100/lpa)) + "% non-binary"
	get_node("Website/Demographics/intersex").text = str((gender_tally.intersex*100/lpa)) + "% Intersex"
var stats
var can_press = false
func _ready() -> void:
	get_node("main/accept").pressed.connect(accept_button)
	get_node("main/reject").pressed.connect(reject_button)
	get_node("Website/edit").pressed.connect(change_website_mode)
	get_node("main/Check").show()
	get_node("main/X").show()
	update_website()
func accept_button():
	if can_press:accept()
	get_node("Click").play()

func reject_button():
	if can_press:reject()
	get_node("Click").play()
func accept():
	main.past_admissions.append(stats)
	get_node("main/stamp").play()
	get_node("main/stamp").frame = 0
	get_node("main/Stamp").play()
	can_press = false
	get_node("main/Application").text = ""
	get_node("Yes").play()
	update_website()
	ac = true
func reject():
	get_node("main/Application").text = ""
	get_node("main/stamp").play()
	get_node("main/Stamp").play()
	get_node("main/stamp").frame = 0
	get_node("No").play()
	can_press = false
	ac = false


var reject_time = 5
var accept_time = 5
var prev_tab = 0

func change_website_mode():
	website_edit_mode = !website_edit_mode
	update_website()

func _physics_process(delta: float) -> void:
	if get_node("main/stamp").frame == 11:
		if ac:accept_time=0
		else:reject_time=0
	get_node("main/Check").modulate.a = 1- (accept_time/2)
	get_node("main/X").modulate.a = 1- (reject_time/2)
	if get_node("TabBar").current_tab != prev_tab:
		prev_tab=get_node("TabBar").current_tab
		get_node("PageTurn").play()
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
	if get_node("TabBar").current_tab == 3:
		get_node("entropy").show()
	else:
		get_node("entropy").hide()
	if get_node("TabBar").current_tab == 4:
		get_node("bytf").show()
	else:
		get_node("bytf").hide()
	if get_node("TabBar").current_tab == 5:
		get_node("budget").show()
	else:
		get_node("budget").hide()


func new_application(stuff):
	get_node("main/Application").text = stuff.name
	get_node("main/Application").text+=".   Born on "+str(stuff.birthday)
	get_node("main/Application").text+=".   From " +stuff.citystate
	get_node("main/Application").text+="!\nDate of Graduation: " + str(stuff.graduated)
	get_node("main/Application").text+="\nAttended: " + stuff.attended
	get_node("main/Application").text+="\nRace: " + main.race_text(stuff.race)
	get_node("main/Application").text+="\nGender: " + stuff.gender
	var classes = "Classes:\n"
	for i in stuff.classes:
		classes+=i.class_name+"     Grade: "+str(i.gpa)+"\n"
	get_node("Transcript/Label").text = classes
	stats = stuff
