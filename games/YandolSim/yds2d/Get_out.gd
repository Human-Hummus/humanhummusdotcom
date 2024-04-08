extends Node2D


var main = null
var door_hitbox

# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_node("/root/MainScript")
	main.olin_hitbox = get_node("Olin/hitbox")
	door_hitbox = get_node("outside")

var time_since_start = 0
var did_slam = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_since_start+=delta
	if !did_slam && time_since_start>=0.5:
		did_slam = true
		main.play_sound("res://assets/cutscenes/door_slam.mp3")
	if did_slam:
		if main.is_collide(door_hitbox):
			get_tree().change_scene_to_file("res://Cutscenes/grade_too_low_left_school.tscn")
		
	
	
