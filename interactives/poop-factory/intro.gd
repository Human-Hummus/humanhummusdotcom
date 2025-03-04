extends Node2D

func _on_start_pressed() -> void:
	$ColorRect.show()
	$AnimationPlayer.play("fade_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://main.tscn")
