extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.show()
	$ColorRect/AnimationPlayer.play("fade_in")
	$Button.pressed.connect(poop)
	$ColorRect2.show()

func poop():
	wrld.add_poop(1)


func _physics_process(delta: float) -> void:
	$tankbar.max_value = wrld.max_poops
	$tankbar.value = wrld.poops
	if $Camera2D.position.x < 574:
		$Camera2D.position.x+=5
	if $Camera2D.position.x > 574:
		$Camera2D.position.x-=5
	if $Camera2D.position.y < 326:
		$Camera2D.position.y+=5
	if $Camera2D.position.y > 326:
		$Camera2D.position.y-=5
		
	



func _on_farm_go_pressed() -> void:
	$farm.show()
	$farm/Activate.play()


func _on_m_pressed() -> void:
	wrld.money*=2

func _on_p_pressed() -> void:
	wrld.poops*=2

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$ColorRect.hide()

var silly_faces = [load("res://faces/1.png"),load("res://faces/2.png"),load("res://faces/3.png"),load("res://faces/4.png"),load("res://faces/5.png")]

var rng = RandomNumberGenerator.new();

func _on_button_button_down() -> void:
	$face.texture = silly_faces.pick_random()
	$sound.play()
	$poop_explosion.emitting = true
	$Camera2D.position.x+=rng.randf_range(-20,20)
	$Camera2D.position.y+=rng.randf_range(-20,20)
	

func _on_button_button_up() -> void:
	$face.texture = load("res://faces/normal.png")


func _on_door_mouse_entered() -> void:
	$DoorCreak.play()
func _on_door_mouse_exited() -> void:
	$DoorSlam.play()
	$DoorCreak.stop()
func _on_door_pressed() -> void:
	$DoorSlam.play()
	$DoorCreak.stop()
	$shops.show()
