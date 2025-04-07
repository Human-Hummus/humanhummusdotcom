extends Node2D

func _on_exit_pressed() -> void:
	$".".hide()
	$Deactivate.play()
