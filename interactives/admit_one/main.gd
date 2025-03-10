extends Node

var total_budget = 10000
func race_text(r):
	if r == race.WT:return "Caucasian (White)"
	if r == race.AS:return "Asian/Pacific Islander"
	if r == race.ME:return "Middle Eastern"
	if r == race.BL:return "Black or African American"
	if r == race.AI:return "American Indian or Alaska Native"
	if r == race.HS:return "Hispanic and Latino Americans"
enum race{
	WT,
	AS,
	ME,
	BL,
	AI,
	HS
}
var dia_open = true
var races = [race.WT, race.AS, race.ME, race.BL, race.AI, race.HS]

const std_stuff = {
	"graduated": "11/12/24",
	"birthday": "1/25/2000",
	"attended": "Epic 100% High School",
	"citystate": "fartsmith, washington",
	"name": "Dan TDM",
	"classes": [],
	"race": race.BL,
	"gender": "female",
}
var genders = "male female intersex non-binary".split(" ")

var budget = {
	"shopping":0,
	"academics":0,
	"athletics":0,
	"professors":0,
	"dorms":0,
	"campus":0,
	"food":0,
	"safety":0,
}
func real_budget() -> int:
	var rb = total_budget
	for i in "shopping academics athletics professors dorms campus food safety".split(" "):
		rb-=budget[i]
	return rb

var subject_pool = [
	"Math",
	"Biology",
	"Chemistry",
	"Physics",
	"English",
	"History"
]

var math_class_name_pool = [
	"Algebra",
	"Geometry",
	"Calculus",
	"Statistics",
	"Discrete Math",
	"Linear Algebra",
	"Probability and Statistics"
]

var biology_class_name_pool = [
	"Biology I",
	"Biology II",
	"Ecology",
	"Botany",
	"Zoology",
	"Genetics",
	"Evolution"
]

var chemistry_class_name_pool = [
	"Chemistry Lab",
	"General Chemistry",
	"Organic Chemistry",
	"Physical Chemistry",
	"Biochemistry",
	"Environmental Science",
	"Forensic Science"
]

var physics_class_name_pool = [
	"Physics 101",
	"Physics 102",
	"Astronomy",
	"Earth Science",
	"Environmental Physics",
	"Mechanics",
	"Thermodynamics"
]

var english_class_name_pool = [
	"English Lit",
	"Composition",
	"Poetry Analysis",
	"Short Story Analysis",
	"Creative Writing",
	"Rhetoric and Public Speaking",
	"Literary Theory"
]

var history_class_name_pool = [
	"US History",
	"World History",
	"Ancient Civilizations",
	"European History",
	"Asian Studies",
	"African Studies",
	"Middle Eastern Studies"
]

func create_random_class():
	var subject = subject_pool[randi() % len(subject_pool)]
	
	if subject == "Math":
		return {
			"class_name": math_class_name_pool[randi() % len(math_class_name_pool)],
			"gpa": round_to_dec(randf_range(0.0, 4.0),1),
			"subject": subject
		}
		
	elif subject == "Biology":
		return {
			"class_name": biology_class_name_pool[randi() % len(biology_class_name_pool)],
			"gpa": round_to_dec(randf_range(0.0, 4.0),1),
			"subject": subject
		}
		
	elif subject == "Chemistry":
		return {
			"class_name": chemistry_class_name_pool[randi() % len(chemistry_class_name_pool)],
			"gpa": round_to_dec(randf_range(0.0, 4.0),1),
			"subject": subject
		}
		
	elif subject == "Physics":
		return {
			"class_name": physics_class_name_pool[randi() % len(physics_class_name_pool)],
			"gpa": round_to_dec(randf_range(0.0, 4.0),1),
			"subject": subject
		}
		
	elif subject == "English":
		return {
			"class_name": english_class_name_pool[randi() % len(english_class_name_pool)],
			"gpa": round_to_dec(randf_range(0.0, 4.0),1),
			"subject": subject
		}
		
	elif subject == "History":
		return {
			"class_name": history_class_name_pool[randi() % len(history_class_name_pool)],
			"gpa": round_to_dec(randf_range(0.0, 4.0),1),
			"subject": subject
		}

var past_admissions = []
var names = "Benis Vane P.P. Shungite Tux Wobblebottom Furry Balls Walmart Chair YonKaGor Human Hummus Benadryl Borax Doofus Drungy Michael Dan Daniel Drungalwort Fart Poopy Goober".split(" ")
var schools = "Academy for Cringe,Based Private School,Cringe Private School".split(",")
var states = "AK AL AR AZ CA CO CT DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY DC AS GU MP PR VI".split(" ")
var cities = "Anytown,Canterlot,Ponyville,New York".split(",")

func new_app():
	var app = std_stuff.duplicate()
	var yob = randi_range(1910,2024-18)
	app.graduated = str(randi_range(0,12))+"/"+str(randi_range(0,31))+"/"+str(yob+18)
	app.birthday = str(randi_range(0,12))+"/"+str(randi_range(0,31))+"/"+str(yob)
	app.attended = str(schools[randi()%schools.size()])
	app.citystate = str(cities[randi()%cities.size()])+", "+str(states[randi()%states.size()])
	app.name = str(names[randi()%names.size()])+" "+str(names[randi()%names.size()])
	app.classes = []
	app.gender = genders[randi()%genders.size()]
	for i in range(0,10):
		app.classes.append(create_random_class())
	app.race = races[randi() % races.size()]
	return app
func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
	
