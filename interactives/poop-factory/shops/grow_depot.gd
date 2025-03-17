extends Control

var selected = "rice"

func _physics_process(delta: float) -> void:
	if selected == "":
		$Label.text = "Select an item!"
	elif selected == "rice":
		$Label.text = "Rice. $2.00. Will sell for $2.00, but takes 150 poops to fully grow. Requires 1 poop/second minimum"
	elif selected == "barley":
		$Label.text = "Barley. $5.00. Will sell for $5.00, but takes 200 poops to fully grow. Requires 2 poop/second minimum"
	elif selected == "corn":
		$Label.text = "Corn. $10.00. Will sell for $20.00, but takes 500 poops to fully grow. Requires 5 poop/second minimum"
	if selected in wrld.crops:$Label.text = "Already Purchased"


func _on_exit_pressed() -> void:
	$".".hide()


func _on_select_rice_pressed() -> void:
	selected = "rice"
func _on_select_barley_pressed() -> void:
	selected = "barley"


func _on_buy_pressed() -> void:
	if selected == "rice":
		if (not ("rice" in wrld.crops)) and wrld.try_buy(2):
			wrld.crops["rice"] = {
				"sells": 2,
				"requires":150,
				"persecond":1
			}
			$Buy.play()
	if selected == "barley":
		if (not ("barley" in wrld.crops)) and wrld.try_buy(5):
			wrld.crops["barley"] = {
				"sells": 5,
				"requires":200,
				"persecond":2
			}
			$Buy.play()
	if selected == "corn":
		if (not ("corn" in wrld.crops)) and wrld.try_buy(10):
			wrld.crops["corn"] = {
				"sells": 20,
				"requires":500,
				"persecond":5
			}
			$Buy.play()
	else:
		pass
	selected = ""


func _on_select_corn_pressed() -> void:
	selected = "corn"
