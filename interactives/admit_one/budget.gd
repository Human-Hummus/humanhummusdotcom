extends Control
var cur_dept = ""

func _ready() -> void:
	set_thing("academics")
	var vbc = "CenterContainer/HBoxContainer/VBoxContainer/"
	get_node(vbc + "shopping").pressed.connect(set_thing.bind("shopping"))
	get_node(vbc + "academics").pressed.connect(set_thing.bind("academics"))
	get_node(vbc + "athletics").pressed.connect(set_thing.bind("athletics"))
	get_node(vbc + "professors").pressed.connect(set_thing.bind("professors"))
	get_node(vbc + "dorms").pressed.connect(set_thing.bind("dorms"))
	get_node(vbc + "campus").pressed.connect(set_thing.bind("campus"))
	get_node(vbc + "food").pressed.connect(set_thing.bind("food"))
	get_node(vbc + "safety").pressed.connect(set_thing.bind("safety"))

func set_thing(thing):
	
	cur_dept = thing
	get_node("CenterContainer/HBoxContainer/VBoxContainer2/slider").value = main.budget[cur_dept]
	get_node("CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer/department").text = get_node("CenterContainer/HBoxContainer/VBoxContainer/"+thing).text

func _process(delta: float) -> void:
	get_node("CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer3/tbudget").text = "$" + str(main.real_budget())
	get_node("CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer2/budget").text = "$" + str(main.budget[cur_dept])
	main.budget[cur_dept] = get_node("CenterContainer/HBoxContainer/VBoxContainer2/slider").value
	get_node("CenterContainer/HBoxContainer/VBoxContainer2/slider").max_value = main.real_budget() + main.budget[cur_dept]
