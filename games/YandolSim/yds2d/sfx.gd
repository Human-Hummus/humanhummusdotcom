extends Node2D

var main = null
# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_node("/root/MainScript")

var playing_sounds = []
var garbage_collect_progress = 0

func _physics_process(delta):
	#print("playing_sounds:" + str(playing_sounds) + " garbage_progress: " + str(garbage_collect_progress) + " main.sounds_to_play" + str(main.sounds_to_play))
	garbage_collect_progress+=delta
	if garbage_collect_progress >= main.garbage_collect_interval:
		garbage_collect_progress=0
		var x = 0
		var new_playing_sounds = []
		while x < len(playing_sounds):
			if !playing_sounds[x].playing:
				playing_sounds[x].queue_free()
			else:
				new_playing_sounds.append(playing_sounds[x])
			x+=1
		playing_sounds = new_playing_sounds
	for i in main.sounds_to_play:
		play_sound(i)
	main.sounds_to_play = []
				


func play_sound(file):
	var add_sound = AudioStreamPlayer2D.new()
	add_sound.stream = load(file)
	add_child(add_sound)
	add_sound.play()
	playing_sounds.append(add_sound)
	
	
