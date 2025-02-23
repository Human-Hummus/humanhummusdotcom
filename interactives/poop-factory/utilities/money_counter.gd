extends Node2D


# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	$Label.text = "$" + str(wrld.money)
