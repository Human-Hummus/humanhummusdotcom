extends Node2D

var throws = 10
var throws_display
var ball = null
var ball_collide = null
var bh = -500
const bstep = 10
var sb = null

var character
var xpos = 0
var button
var time_playing = 0

const max_x = 1000
const min_x = 50
var x_step = 10
var main = null



# Called when the node enters the scene tree for the first time.
func _ready():
	button = get_node("throw")
	character = get_node("dude")
	button.pressed.connect(throw_ball)
	throws_display = get_node("throws")
	ball = get_node("ball")
	
	sb=get_node("score")
	main = get_node("/root/MainScript")
	main.bbscore = 0
	
func throw_ball():
	main.play_sound("res://assets/bloing.mp3")
	ball.global_position = Vector2(xpos, 100)
	bh = 500
	
	throws-=1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	time_playing+=delta
	if time_playing<0.3:return
	print(get_node(".").get_children())
	throws_display.clear()
	throws_display.add_text(str(throws) + " throws left")
	sb.clear()
	sb.add_text("Score: " + str(main.bbscore))
	if xpos > max_x:
		xpos = max_x
		x_step*=-1
	if xpos < min_x:
		xpos = min_x
		x_step*=-1
	xpos+=x_step
	character.global_position = Vector2(xpos,500)
	ball.global_position = Vector2(xpos, bh)
	bh-=bstep
	
	if bh < 230 && bh >100 && xpos>700 && xpos <1000:
		main.bbscore+=10+round(main.bbscore**0.25)
		
		bh = -100
	if throws == 0:
		main.updatebbscore = true
		get_tree().change_scene_to_file("res://main.tscn")
		

