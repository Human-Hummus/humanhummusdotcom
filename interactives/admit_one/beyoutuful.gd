extends Control

func _ready() -> void:
	get_node("TextureButton").pressed.connect(play_video)
func play_video() -> void:
	get_node("AnimatedSprite2D").play()
	get_node("TextureButton").hide()
	get_node("InternetSafetyDemo").play()
func _process(delta:float) -> void:
	if get_node("AnimatedSprite2D").frame == 112:
		get_node("AnimatedSprite2D").frame = 0
		get_node("AnimatedSprite2D").stop()
		get_node("InternetSafetyDemo").stop()
		get_node("TextureButton").show()
		
