extends Node2D

var crop = ""
var completed = 0
var is_dead = false

func is_ready():
	if crop == "":return false
	if completed >= wrld.crops[crop].requires:return true
	return false

func update_ob():
	var items = []
	for i in range(0,%OptionButton.item_count):
		items.append(%OptionButton.get_item_text(i))
	for i in wrld.crops:
		if not (i in items):
			%OptionButton.add_item(i)
func _physics_process(delta: float) -> void:
	update_ob()
	if crop != "":
		%Label.text = crop + "; " + str(round(completed)) + "/" + str(wrld.crops[crop].requires)
		%ProgressBar.value = completed
		%ProgressBar.max_value = wrld.crops[crop].requires
	else:
		%Label.text = "Null"
		%ProgressBar.max_value = 1
		%ProgressBar.value = 0
	if crop == "":
		%Button.text = "Plant " + %OptionButton.get_item_text(%OptionButton.selected)
		%ProgressBar.value = 0
	elif is_ready():
		%Button.text = "Harvest " + crop + " for $" + str(wrld.crops[crop].sells)
	elif is_dead:
		%Button.text = "Remove dead crop"
	elif wrld.poops+completed >= wrld.crops[crop].requires:
		%Button.text = "Fertilize " + crop + " for " + str(round(wrld.crops[crop].requires-completed))
		wrld.poops-=wrld.crops[crop].persecond*delta
		completed+=wrld.crops[crop].persecond*delta
	else:
		%Button.text = crop + " consuming " + str(wrld.crops[crop].persecond) + "/s"
		if wrld.poops < wrld.crops[crop].persecond:
			is_dead = true
		else:
			wrld.poops-=wrld.crops[crop].persecond*delta
			completed+=wrld.crops[crop].persecond*delta
func _on_button_pressed() -> void:
	if crop == "":
		#plant
		crop = %OptionButton.get_item_text(%OptionButton.selected)
		is_dead = false
	elif is_ready():
		#harvest
		wrld.add_money(wrld.crops[crop].sells)
		crop = ""
		completed = 0
	elif is_dead:
		#remove dead crop
		crop = ""
	elif wrld.poops+completed >= wrld.crops[crop].requires:
		#fertilize
		wrld.poops-=wrld.crops[crop].requires-completed
		completed = wrld.crops[crop].requires
	else:
		#do nothing
		pass
