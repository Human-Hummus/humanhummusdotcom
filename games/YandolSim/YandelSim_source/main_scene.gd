extends Node2D

var main = null
var door = null
# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_node("/root/MainScript")
	door = get_node("door")
	main.road_collide = get_node("Houses")


var deleted_door = false
func _physics_process(delta):
	if deleted_door == false:
		if main.data.met_yandel:
			deleted_door=true
			door.queue_free()
	if main.data.got_karisan_body:
		main.data.got_karisan_body = false
		get_node("karisan").queue_free()
			
