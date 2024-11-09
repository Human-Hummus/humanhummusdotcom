extends Node2D

var text_to_say = " "
var done = true
var text_said:float = 0

func _ready() -> void:
	get_node("AnimatedSprite2D").play()
	get_node("Close").pressed.connect(close)
	get_node("Open").pressed.connect(open)	
func close():
	get_node("Close2").play()
	get_node("Open").show()
	get_node("Close").hide()
	get_node("AnimatedSprite2D").hide()
	get_node("Label").hide()
func open():
	get_node("Open2").play()
	get_node("Open").hide()
	get_node("Close").show()
	get_node("AnimatedSprite2D").show()
	get_node("Label").show()

func _physics_process(delta: float) -> void:
	if done == false:
		text_said+=0.75
		#var tmp
		#if randi()%2 == 0:
		#	tmp = get_node("Click").duplicate()
		#else:tmp=get_node("Type").duplicate()
		#get_node(".").add_child(tmp)
		#tmp.play()
		
		if text_said >= len(text_to_say):
			done = true
			return
	var to_say = ""
	for i in range(0,round(text_said)):
		if i < len(text_to_say):to_say+=text_to_say[i]
	get_node("Label").text = to_say
func say_stuff(tts):
	text_to_say = tts
	done = false
	text_said = false
