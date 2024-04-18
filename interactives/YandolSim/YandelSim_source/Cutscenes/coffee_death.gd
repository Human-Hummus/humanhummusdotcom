extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var main = get_node("/root/MainScript")
	if main.is_dead:
		get_node("AudioStreamPlayer2D").play()
	pass
