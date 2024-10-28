extends Node2D

var done = [false, false, false, false]
var time_won = 0
var time = 0
func _ready():
	get_node("sinq/Button").pressed.connect(correct_1)
	get_node("sinq/Button2").pressed.connect(l)
	get_node("sinq/Button3").pressed.connect(l)
	get_node("scareq/Button").pressed.connect(correct_2)
	get_node("scareq/Button2").pressed.connect(l)
	get_node("scareq/Button3").pressed.connect(l)
	get_node("scareq2/Button").pressed.connect(correct_3)
	get_node("scareq2/Button2").pressed.connect(l)
	get_node("scareq2/Button3").pressed.connect(l)
	get_node("scareq3/Button").pressed.connect(l)
	get_node("scareq3/Button2").pressed.connect(correct_4)
	get_node("scareq3/Button3").pressed.connect(l)
	
	
func correct_1():
	get_node("Correct").play()
	done[0] = true
	get_node("Check").show()
func correct_2():
	get_node("Correct").play()
	done[1] = true
	get_node("Check2").show()
func correct_3():
	get_node("Correct").play()
	done[2] = true
	get_node("Check3").show()
func correct_4():
	get_node("Correct").play()
	done[3] = true
	get_node("Check4").show()
func l():get_tree().change_scene_to_file("res://loss.tscn")

func is_done():
	for i in done:if i != true:return false
	return true
func _process(delta):
	time+=delta
	get_node("sinq").text = "What is the sin of" + str(time)
	get_node("sinq/Button").text =  str(sin(time))
	get_node("sinq/Button2").text = str(cos(time))
	get_node("sinq/Button3").text = str(tan(time))
	if is_done():
		if time_won==0:get_node("YouWin").play()
		time_won+=delta
	if time_won>=3:
		get_tree().change_scene_to_file("res://fight_to_class.tscn")
