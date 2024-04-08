extends Control


var main = null
var text_box = null
var button_container = null
var img = null
var sound_thing = null
var charimg = null
var border = null
# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_node("/root/MainScript")
	text_box = get_node("displayed text")
	button_container = get_node("VBoxContainer")
	img = get_node("black")
	sound_thing = get_node("bebebeba")
	charimg = get_node("icon")
	border = get_node("Border")
	get_node("displayed text/text_press").pressed.connect(enable_interact)

func enable_interact():main.interact = true

func pressed_response(bnum):
	cur_progress=0
	displayed_options=false
	main.statement.instant_finish = false
	for child in button_container.get_children():
		child.queue_free()
	main.pressed_response(bnum)

	
var cur_progress = 0
var displayed_options = false
func _physics_process(delta):
	if !main.is_talking():
		img.hide()
		text_box.hide()
		charimg.hide()
		border.hide()
		return
	else:
		border.show()
		img.show()
		text_box.show()
		charimg.show()

		if main.statement.talking == "yandel":
			charimg.frame = 2
		elif main.statement.talking == "mr c":
			charimg.frame = 1
		elif main.statement.talking == "mcglee":
			charimg.frame = 3
		elif main.statement.talking == "olin":
			charimg.frame = 4
		else:
			charimg.frame = 0
		var start_text = main.statement.displayed_text
		if main.statement.instant_finish:
			cur_progress=0
			main.statement.displayed_text = main.statement.text
		elif main.statement.text != main.statement.displayed_text:
			cur_progress+=delta
			if cur_progress>=main.char_time:
				cur_progress=0
				main.statement.displayed_text+=main.statement.text[len(main.statement.displayed_text)]
				click_sound()
		if start_text != main.statement.displayed_text:
			text_box.text = main.statement.displayed_text
		
		if main.statement.text == main.statement.displayed_text && !displayed_options:
			displayed_options = true
			var x = 0
			while x < len(main.statement.options):
			
				var button = Button.new()
				button.pressed.connect(func(): (pressed_response(x)))
				button.text = main.statement.options[x]
				button_container.add_child(button)
				x+=1

	
func click_sound():
	var sounds = [
		#load("res://assets/bebebe/alarm.mp3"), 
		load("res://assets/bebebe/dogbark.mp3"),
		load("res://assets/bebebe/roar.mp3"),
		load("res://assets/bebebe/whistle.mp3"),
		#load("res://assets/bebebe/wow.mp3"),    
		load("res://assets/bebebe/1.mp3"),
		load("res://assets/bebebe/2.mp3"),
		load("res://assets/bebebe/3.mp3"),
		load("res://assets/bebebe/4.mp3"),
		load("res://assets/bebebe/5.mp3"),      
		]
	var file_to_play = sounds[randi_range(0,len(sounds)-1)]
	sound_thing.stream = file_to_play
	sound_thing.play()

#func click_sound():
#	var sounds = [
#		#load("res://assets/bebebe/alarm.mp3"), 
#		"res://assets/bebebe/dogbark.mp3",
#		"res://assets/bebebe/roar.mp3",
#		"res://assets/bebebe/whistle.mp3",
		#load("res://assets/bebebe/wow.mp3"),    
#		"res://assets/bebebe/1.wav",
#		"res://assets/bebebe/2.wav",
#		"res://assets/bebebe/3.wav",
#		"res://assets/bebebe/4.wav",
#		"res://assets/bebebe/5.wav",      
#		]
#	var file_to_play = sounds[randi_range(0,len(sounds)-1)]
#	main.sounds_to_play.append(file_to_play)
