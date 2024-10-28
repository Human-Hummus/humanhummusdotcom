extends Node2D
var time = 0
var cooldown = 0
var ballspeed = 10
var camera
var ball
var attempts = 0
var wins = 0
var final_attempt_time = 0


func _ready():
	camera = get_node("Camera3D")
	ball = get_node("ball")

func _process(delta):
	time += delta
	if attempts >=5:
		cooldown+=1  
		if final_attempt_time == 0:
			if wins/attempts >= 0.6:get_node("Camera3D/YouWin").play()
		final_attempt_time += delta
	if final_attempt_time > 5:
		if wins/attempts >= 0.6:get_tree().change_scene_to_file("res://fight_to_class.tscn")
		else:get_tree().change_scene_to_file("res://loss.tscn")
	cooldown -= delta
	ballspeed-=delta*20*2
	ball.position.z -=10*delta*2
	camera.position.x = sin(time*2)*20
	ball.position.y += delta*ballspeed*2
	if len(get_node("basketball/Area3D").get_overlapping_areas()) > 0:
		get_node("Camera3D/Correct").play()
		wins+=0.5
		ball.position.z = -10000
	var text = "Shoot hoops! Get at least 3/5! (" + str(wins) + "/" + str(attempts) + ")"
	get_node("Camera3D/text").text = text 
	if Input.is_action_pressed("ui_accept") && cooldown <= 0:
		cooldown = 1.5
		attempts+=1
		get_node("Camera3D/Grunt").play()
		ball.position.y = camera.position.y
		ball.position.x = camera.position.x
		ball.position.z = camera.position.z
		ballspeed = 30
