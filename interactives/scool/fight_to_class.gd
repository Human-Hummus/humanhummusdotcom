extends Node3D


var time_passed = 0
var camera
var enemy_imgs=4


func _ready():
	Main.class_number+=1
	var enemies = round(1.5*Main.class_number)
	camera = get_node("Camera3D")
	for i in range(0,enemies):
		var thing = get_node("example").duplicate()

		get_node("hellway").add_child(thing)
		var texture = load("assets/scary people/" + str(randi() % enemy_imgs ) + ".webp")
		thing.texture = texture
		thing.position.x=randf_range(-7,7)
		thing.position.z=randf_range(-15,15)
		print(thing.position.y)
		thing.position.y=0

var speed = 5

var realx = 0
func _process(delta):
	#print(get_node("Camera3D/Area3D").get_overlapping_areas())
	if len(get_node("Camera3D/Area3D").get_overlapping_areas()) >0:
		get_tree().change_scene_to_file("res://loss.tscn")
	if Input.is_action_pressed("ui_left"):realx-=speed*delta
	if Input.is_action_pressed("ui_right"):realx+=speed*delta
	if Input.is_action_pressed("ui_up"):camera.position.z-=speed*delta
	time_passed+=delta
	camera.position.z-=delta*4
	camera.position.y = sin(time_passed*10)
	camera.position.x = realx + sin(time_passed*7)/4
	if camera.position.z < -15:
		go_to_class()
		
func go_to_class():
	print("GOT TO CLASS")
	print("res://class" + str(Main.class_number) + ".tscn")
	get_tree().change_scene_to_file("res://class" + str(Main.class_number) + ".tscn")	
