extends Node

const std_stuff = {
	"graduated": "0/0/0",
	"birthday": "0/0/0",
	"attended": "nill",
	"citystate": "fartsmith, washington",
	"name": "Dan TDM",
	"sci_gpa": 0.0,
	"social_gpa":0.0,
	"ela_gpa":0.0,
	"math_gpa":0.0,
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
	app.sci_gpa = round_to_dec(randf_range(0,4), 1)
	app.social_gpa = round_to_dec(randf_range(0,4), 1)
	app.ela_gpa = round_to_dec(randf_range(0,4), 1)
	app.math_gpa = round_to_dec(randf_range(0,4), 1)
	return app
func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
	
