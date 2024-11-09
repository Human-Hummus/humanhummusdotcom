extends Node

const std_stuff = {
	"graduated": "0/0/0",
	"birthday": "0/0/0",
	"attended": "nill",
	"citystate": "fartsmith, washington",
	"name": "Dan TDM",
	"classes": [],
}

var subject_pool = [
	"Mathematics",
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
	
	if subject == "Mathematics":
		return {
			"class_name": math_class_name_pool[randi() % len(math_class_name_pool)],
			"gpa": round_to_dec(randf_range(0.0, 4.5),1),
			"subject": subject
		}
		
	elif subject == "Biology":
		return {
			"class_name": biology_class_name_pool[randi() % len(biology_class_name_pool)],
			"gpa": round_to_dec(randf_range(0.0, 4.5),1),
			"subject": subject
		}
		
	elif subject == "Chemistry":
		return {
			"class_name": chemistry_class_name_pool[randi() % len(chemistry_class_name_pool)],
			"gpa": round_to_dec(randf_range(0.0, 4.5),1),
			"subject": subject
		}
		
	elif subject == "Physics":
		return {
			"class_name": physics_class_name_pool[randi() % len(physics_class_name_pool)],
			"gpa": round_to_dec(randf_range(0.0, 4.5),1),
			"subject": subject
		}
		
	elif subject == "English":
		return {
			"class_name": english_class_name_pool[randi() % len(english_class_name_pool)],
			"gpa": round_to_dec(randf_range(0.0, 4.5),1),
			"subject": subject
		}
		
	elif subject == "History":
		return {
			"class_name": history_class_name_pool[randi() % len(history_class_name_pool)],
			"gpa": round_to_dec(randf_range(0.0, 4.5),1),
			"subject": subject
		}

var past_admissions = []
const names = ["Gabe", "Gabriel", "Michael", "Dan", "Daniel", "Drungalwort", "Fart", "Poopy", "Goober"]
const schools = ["Academy for Cringe", "Based Private School", "Cringe Private School"]
var states = "WA VT KS IL UT CA NY FL".split(" ")
var cities = ["Anytown", "Canterlot", "Ponyville"]

func new_app():
	var app = std_stuff.duplicate()
	app.graduated = str(randi_range(0,12))+"/"+str(randi_range(0,31))+"/"+str(randi_range(1900,2300))
	app.birthday = str(randi_range(0,12))+"/"+str(randi_range(0,31))+"/"+str(randi_range(999,2000))
	app.attended = str(schools[randi()%schools.size()])
	app.citystate = str(cities[randi()%cities.size()])+", "+str(states[randi()%states.size()])
	app.name = str(names[randi()%names.size()])+" "+str(names[randi()%names.size()])
	app.classes = []
	for i in range(0,10):
		app.classes.append(create_random_class())
	return app
func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
	
