extends Node3D


func _ready():
	pass
func _process(delta):
	#get_node("Sprite3D/Area3D/CollisionShape3D").input_ray_pickable = true
	get_node("Sprite3D3/Area3D").connect("input_event", lava)
	get_node("Sprite3D/Area3D").connect("input_event", other)
	get_node("Sprite3D2/Area3D").connect("input_event", other)
	
func lava(_camera: Node, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int):
	if event.is_pressed() == true:
		get_tree().change_scene_to_file("res://w.tscn")
func other(_camera: Node, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int):
	if event.is_pressed() == true:
		get_tree().change_scene_to_file("res://loss.tscn")
