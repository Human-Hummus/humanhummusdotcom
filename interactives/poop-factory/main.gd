extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.show()
	$ColorRect/AnimationPlayer.play("fade_in")
	$Button.pressed.connect(poop)

func poop():
	wrld.add_poop(1)


func _physics_process(delta: float) -> void:
	$poops.text = "Poops: " + str(round(wrld.poops)) + "/" + str(wrld.max_poops)



func _on_farm_go_pressed() -> void:
	$farm.show()


func _on_m_pressed() -> void:
	wrld.money*=2

func _on_p_pressed() -> void:
	wrld.poops*=2


func _on_shop_go_pressed() -> void:
	$shops.show()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$ColorRect.hide()

var silly_faces = [load("res://faces/1.png"),load("res://faces/2.png"),load("res://faces/3.png"),load("res://faces/4.png"),load("res://faces/5.png")]

func _on_button_button_down() -> void:
	$face.texture = silly_faces.pick_random()
	$sound.play()
	

func _on_button_button_up() -> void:
	$face.texture = load("res://faces/normal.png")
