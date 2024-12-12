extends Control
var ob
func _ready() -> void:
	ob = get_node("OptionButton")
	ob.add_item("9084256589")
	ob.add_item("5412397651")
	ob.add_item("6938102690")
	ob.add_item("MiyAI")

var messages_0 = ["CONGRATULATIONS! You’ve just been chosen as the WINNER of our annual $5,000 Epic Learners Scholarship! Log into your account and confirm your information to claim NOW!!!---> https://WINNER/claim?v=K1bqOLECS98 "]
var messages_1 = ["Hi, we’ve been trying to contact you about a recent motor accident. You should have received a notice in the mail detailing your compensation eligibility. Since we have not gotten a response, we are extending one final courtesy call before we close your file. Type “STOP” to cancel and be placed on our do-not-call list. Type “HELP” to speak with a qualified accident lawyer."]
var messages_2 = ["Your library card is overdue for a renewal. Please sign in to renew your card or type “CANCEL” to terminate your card. Failure to respond will result in automatic fees placed on your account."]

#add children, labels
func add_c_l(og, childs):
	for i in childs:
		var nc = Label.new()
		nc.text = i
		nc.autowrap_mode = TextServer.AUTOWRAP_WORD
		nc.theme = Theme.new()
		nc.add_theme_font_size_override("font_size", 32)
		og.add_child(nc)

func update():
	var vb = get_node("VBoxContainer")
	for n in vb.get_children():
		vb.remove_child(n)
		n.queue_free()
	if ob.selected == 0:
		add_c_l(vb, messages_0)
	if ob.selected  == 1:
		add_c_l(vb, messages_1)
	if ob.selected  == 2:
		add_c_l(vb, messages_2)
	


var prev_s = -1
func _process(delta: float) -> void:
	if prev_s != ob.selected:
		prev_s = ob.selected
		update()
	print(ob.selected)
