extends Node2D

var button1 = null
var button2 = null
var button3 = null
var button4 = null
var instructions = null
var ok_button = null
var main = null

var instruction_number = 0.0
var score = 0.0

var preamble = [
	"Welcome to JasperLazy!",
	"This window will tell you what button to press.",
	"Then, press that button!",
	"You will be graded on the number of buttons you pressed correctly.",
	"There are about ten rounds.",
	"Let's go!"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_node("/root/MainScript")
	button1 = get_node("Button1")
	button2 = get_node("Button2")
	button3 = get_node("Button3")
	button4 = get_node("Button4")
	instructions = get_node("RigidBody2D/instructions")
	ok_button = get_node("RigidBody2D/ok")
	
	button1.pressed.connect(button1_press)
	button2.pressed.connect(button2_press)
	button3.pressed.connect(button3_press)
	button4.pressed.connect(button4_press)
	ok_button.pressed.connect(ok_press)
	
	instructions.text = preamble[0]

var buttons_to_press = [1,3,2,4,1,3,2,3,2,2,4]
var button_number = 0
var is_showing_score = false


func ok_press():
	instruction_number+=1
	main.play_sound("res://assets/Other/SFX/click.mp3")
	if instruction_number>=len(preamble):
		if is_showing_score:
			main.started = true
			main.time_since_start = 0
			main.data.grade_points += score
			main.data.total_grade_points += len(buttons_to_press)
			get_tree().change_scene_to_file("res://main.tscn")
			return	
		
		if button_number >= len(buttons_to_press):
			is_showing_score=true
			instructions.text = "You finished with a score of " + str(round((score/len(buttons_to_press))*100)) + "%."
			return
		

		ok_button.hide()
		button1.show()
		button2.show()
		button3.show()
		button4.show()
		instructions.text = "Press button " + str(buttons_to_press[button_number])
		
		return
	instructions.text = preamble[instruction_number]

func wrong():
	main.play_sound("res://assets/Other/SFX/incorrect.mp3")
	instructions.text = "Incorrect!\n\nThis shouldn't be a challenge..."
	ok_button.show()
	button1.hide()
	button2.hide()
	button3.hide()
	button4.hide()
	button_number+=1
	
func right():
	main.play_sound("res://assets/Other/SFX/correct.mp3")
	score+=1
	instructions.text = "Correct!"
	ok_button.show()
	button1.hide()
	button2.hide()
	button3.hide()
	button4.hide()
	button_number+=1


func button1_press():
	if buttons_to_press[button_number]!=1:
		wrong()
		return
	right()
		
func button2_press():
	if buttons_to_press[button_number]!=2:
		wrong()
		return
	right()
func button3_press():
	if buttons_to_press[button_number]!=3:
		wrong()
		return
	right()
func button4_press():
	if buttons_to_press[button_number]!=4:
		wrong()
		return
	right()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
