extends Node3D

var goal = [0,0]
var tslp = 10
var frog
var drungy
var speed = 5
var frog_speed=10
func _ready() -> void:
	drungy = get_node("drungy")
	frog = get_node("frog")


func _process(delta: float) -> void:
	tslp+=delta
	if len(get_node("drungy/Area3D").get_overlapping_areas()) >0:
		get_tree().change_scene_to_file("res://fight_to_class.tscn")
	if Input.is_action_pressed("ui_down"):
		drungy.position.z += speed*delta
	if Input.is_action_pressed("ui_up"):
		drungy.position.z -= speed*delta
	if Input.is_action_pressed("ui_left"):
		drungy.position.x -= speed*delta
	if Input.is_action_pressed("ui_right"):
		drungy.position.x += speed*delta
	if tslp>=1:
		tslp=0
		goal=[randi_range(-5,5), randi_range(-5,5)]
	if frog.position.z < goal[0]:
		frog.position.z += frog_speed*delta
	if frog.position.z > goal[0]:
		frog.position.z -= frog_speed*delta
	if frog.position.x < goal[1]:
		frog.position.x += frog_speed*delta
	if frog.position.x > goal[1]:
		frog.position.x -= frog_speed*delta
