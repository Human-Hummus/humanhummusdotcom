extends Node2D

const songs = [
	"res://assets/music/heathermusic.mp3"
	
]
var asp = null

func _ready():
	asp = get_node("AudioStreamPlayer2D")
	
func _physics_process(delta):
	if asp.playing == false:
		asp.stream = load(songs[randi_range(0,len(songs)-1)])
		asp.play()
