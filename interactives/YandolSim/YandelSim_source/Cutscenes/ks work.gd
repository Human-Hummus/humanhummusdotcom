extends Node2D
var main = null
var time_ans_displayed = 0
var ans = false
var answer_display = null
var score_display = null
var sentence_display = null
var button1 = null
var button2 = null
var button3 = null
var correct_answer = 0
var rounds_left = 5
var random = RandomNumberGenerator.new()

const right_answer_score = 10

func _ready():
	main = get_node("/root/MainScript")
	answer_display = get_node("wasrights")
	score_display = get_node("score")
	sentence_display = get_node("Sentence")
	button1 = get_node("Button")
	button2 = get_node("Button2")
	button3 = get_node("Button3")
	button1.pressed.connect(button1_pressed)
	button2.pressed.connect(button2_pressed)
	button3.pressed.connect(button3_pressed)
	refresh_sentences()
	
	
func correct():
	ans = true
	print("yay")
	time_ans_displayed = 3
	main.score+=1
	main.max_score+=1
	rounds_left-=1
	refresh_sentences()
func incorrect():
	ans = false
	print("nay")
	time_ans_displayed = 3
	main.max_score+=1
	rounds_left-=1
	refresh_sentences()

func button1_pressed():
	print("button1")
	print(correct_answer)
	if correct_answer == 1:correct()
	else:incorrect()
func button2_pressed():
	print("button2")
	print(correct_answer)
	if correct_answer == 2:correct()
	else:incorrect()
func button3_pressed():
	print("button3")
	print(correct_answer)
	if correct_answer == 3:correct()
	else:incorrect()

func refresh_sentences():
	if rounds_left<=0:
		main.combobulate_score()
		get_tree().change_scene_to_file("res://main.tscn")
	var working_sentence = sentences.pick_random().duplicate()
	var button_text = []
	
	correct_answer = random.randi_range(1,3)
	print(correct_answer)
	sentence_display.text = working_sentence[0]
	for i in range(0,3):
		if i+1 == correct_answer:
			button_text.append(working_sentence[1])
		else:
			button_text.append(wrong_answers.pick_random())
	button1.text = button_text[0]
	button2.text = button_text[1]
	button3.text = button_text[2]
	

const wrong_answers =[
	"I farted",
	"it's true",
	"it isn't true",
	"dfasfdhfjahs",
	"my name isn't capitalized",
	"UwU"
]
const sentences = [
	["I farted.", "farded is spelled wrong"],
	["I love Mr Karisan <3", "it's missing punctuation"],
	["Myrawrs is better than karisan", "karisan isn't capitalized"],
	["Me teacher is Mr Karisan.", "use my instead of me"],
	["They're watching", "it's missing punctuation"]
]

func _physics_process(delta):
	time_ans_displayed-=delta
	score_display.text = str(main.score) + "/" + str(main.max_score) + " correct. " + str(rounds_left) + " rounds left"
	if time_ans_displayed<=0:
		answer_display.hide()
	else:
		answer_display.show()
	if ans == false:
		answer_display.frame = 1
	else:
		answer_display.frame = 0
	
