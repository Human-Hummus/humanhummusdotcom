extends Node2D




func _on_home_pressed() -> void:
	$".".hide()


func _on_go_grow_depot_pressed() -> void:
	$grow_depot.show()
