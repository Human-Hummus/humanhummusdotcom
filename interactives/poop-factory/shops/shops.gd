extends Node2D

func _on_home_pressed() -> void:
	$".".hide()
func _on_go_grow_depot_pressed() -> void:
	$grow_depot.show()
	$vendar_greeting.play()
func _on_go_moes_gizmos_pressed() -> void:
	$gizmoes.show()


func _on_go_public_resources_pressed() -> void:
	$public_resources.show()
	$public_resources/greeting.play()
