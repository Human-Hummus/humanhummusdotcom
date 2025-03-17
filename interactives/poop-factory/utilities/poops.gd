extends Node2D
func _physics_process(delta: float) -> void:
	$CenterContainer/VBoxContainer/Label.text = str(snapped(wrld.poops, 0.1)) + "/" + str(wrld.max_poops) + " Poops"
	$CenterContainer/VBoxContainer/ProgressBar.max_value = wrld.max_poops
	$CenterContainer/VBoxContainer/ProgressBar.value = wrld.poops
