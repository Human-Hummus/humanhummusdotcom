extends Node2D


var textbox = null
var button = null
var blackbox = null

# Called when the node enters the scene tree for the first time.
func _ready():
	blackbox = get_node("Black")
	textbox = get_node("RichTextLabel")
	button = get_node("Button")
	button.pressed.connect(go_to_next_scene)

func go_to_next_scene():
	get_tree().change_scene_to_file("res://get_out.tscn")

var time_passed = 0
var did_text = false
var did_button = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_passed+=delta
	if !did_text && time_passed>3:
		blackbox.show()
		textbox.show()
		did_text=true
	if !did_button && time_passed>5:
		did_button = true
		button.show()
		
