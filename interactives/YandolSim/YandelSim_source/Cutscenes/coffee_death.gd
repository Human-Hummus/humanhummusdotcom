extends Node2D


func _ready():
	if !get_node("/root/MainScript").persistant_data.acheivements.contains("Heart Attack"):
		get_node("/root/MainScript").persistant_data.acheivements+="Heart Attack"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var main = get_node("/root/MainScript")
	if main.is_dead:
		get_node("AudioStreamPlayer2D").play()
	pass
