extends Node2D

func _ready() -> void:
	pass 

var targetx = 100
var targety = 100
var velocity = 50
var time = 0
var cx = 150
var cy = 200

func summon_bubble():
	var bubble = preload("res://bubble.tscn").instantiate()
	bubble.position.y = randi_range(500,600)
	bubble.position.x = randi_range(10,290)
	var bs =randf_range(0.1, 0.5)
	bubble.scale = Vector2(bs, bs)
	$bubbles.add_child(bubble)

func _physics_process(delta: float) -> void:
	time+=delta
	if randi_range(0,50) == 1:
		summon_bubble()
	if time >= 5:
		time = 0
		targetx=randi_range(100,200)
		targety=randi_range(100,350)
	var mov_powx = abs(targetx-cx)/300
	var mov_powy = abs(targety-cy)/300
	if cx < targetx:
		cx+=velocity*delta*mov_powx
	else:
		cx-=velocity*delta*mov_powx
	if cy < targety:
		cy+=velocity*delta*mov_powy
	else:
		cy-=velocity*delta*mov_powy
	$Drungy.position.x = cx
	$Drungy.position.y = cy
