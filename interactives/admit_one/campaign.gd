extends Node2D


func _ready() -> void:
	get_node("AnimationPlayer").play("open")
	pass


func _physics_process(delta: float) -> void:
	if get_node("computer").can_press == false:
		get_node("computer").can_press = true
		get_node("computer").new_application(main.new_app())
