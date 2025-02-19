extends Node2D
func _ready() -> void:$Button.pressed.connect(pop)
func pop():$Pop.play()
var velocity = 50
func _process(delta: float) -> void:
	$'.'.position.y-=velocity*delta
	if $'.'.position.y <= -10:
		$".".queue_free()
func _on_pop_finished() -> void:
	$".".queue_free()
