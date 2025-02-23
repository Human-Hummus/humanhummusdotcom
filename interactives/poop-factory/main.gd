extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
