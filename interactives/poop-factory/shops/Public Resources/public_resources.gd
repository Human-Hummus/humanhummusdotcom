extends Node2D

func _on_exit_pressed() -> void:
	$".".hide()

var selected = 0

func _on_forward_pressed() -> void:
	$Fart.play()
	if selected + 1 < len(wrld.friends):
		selected+=1
	else:
		selected = 0

func _on_back_pressed() -> void:
	$Fart.play()
	if selected > 0:
		selected-=1
	else:
		selected = len(wrld.friends)-1

func _physics_process(delta: float) -> void:
	$image.texture = wrld.friends[selected].image
	$name.text = wrld.friends[selected].name
