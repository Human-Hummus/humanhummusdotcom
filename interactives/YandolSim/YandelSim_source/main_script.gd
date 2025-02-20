extends Node

const save_file_name = "user://yandelere_simulator_save_data.json"
var started = false
var time_since_start = 0
var is_dead = false
var can_interact = false
var is_mobile = false
var boss_health = -1
var myr_collide = null
var house_go = null
var road2_collide = null
var bed_collide = null
var updatebbscore = false
var karisan_collide = null
var meat_collide = null
var trash_collide = null
var is_grade_scene = false
var loreinc_collide = null
var computer_collide = null
var airplane_collide = null

var sentences_minigame = "NONE"

var has_drama = false
var place = "home"
var yandy_collide = null
var gym_collide = null
var yandy_hate = -10
var c_hate =     -10
const death_coffee = 5
var strength = 0
var strength_for_olin = 5
var grade_scene_time = 0
var player = null
var c_collide = null
var mcglee_collide = null
var coffee_collide = null
var road_collide = null
var olin_hitbox = null
var is_in_olin_scene = true
var bully_collide = null

var coffee_effect = 0
var triggered_olin = false
const char_time = 0.03
const standard_run_mul = 2
const more_coffee_mul = 3
var coffee_strength = 4
const coffee_effect_length = 10
const player_normal_speed = 5_000
var player_run_speed_mul = standard_run_mul
var player_run_speed = player_normal_speed * player_run_speed_mul
const player_friction = 10
const step_play_interval_normal = 0.3
var step_play_interval_run = step_play_interval_normal/(player_run_speed/player_normal_speed)
var camera_shake_amount = 3
const yandy_love_death = -20
var bbscore = 0
var pencil_collide = null
var vicdraweria_collide = null

var score = 0
var max_score = 0
var add_score = false

func combobulate_score():
	data.grade_points+=score
	data.total_grade_points+=max_score

var shake_camera = false

const garbage_collect_interval = 0.5
var sounds_to_play = []


const default_data = {
		"yandy_love":0,
		"c_love":0,
		"misc_action":"",
		"coffees_drank":0,
		"grade_points": 5.0,
		"total_grade_points": 10.0,
		"met_myr":false,
		"strength":0.0,
		"karisan_alive": true,
		"got_karisan_body":false,
		
		"met_yandel":false,
		"met_c":false,
		"met_mcglee":false, "mcglee_explained": false,
		"met_gym":false,
		"health":100,
	
		"olin_scene": {
			"fight": null,
			"has_been_saved": false,
			"met_olin":false,
			"has_chosen":false,
			"unscheduled_disection":false,
			"freedom":false,
		},
		
		"money": 0,
		
		"inventory":[],
		"coffee_has_drugs":false,
		"seen_plane":false,
	}
	
var persistant_data = {
	"acheivements":""
}

const default_statement = {
	"text":"",
	"displayed_text":"",
	"options":[],
	"talking":"none",
	"instant_finish":false
}
var statement = default_statement.duplicate()
var data = default_data.duplicate()
func start_up():
	data = default_data.duplicate()
	data.inventory = []
	statement = default_statement.duplicate()
	started = true
	is_dead = false
	can_interact = false
	boss_health = -1
	triggered_olin=false

	has_drama = false
	place = "home"
	strength = 0
	is_grade_scene = false
	grade_scene_time = 0
	is_in_olin_scene = true
	coffee_effect = 0
	coffee_strength = 4
	player_run_speed_mul = standard_run_mul
	print("started")
	get_tree().change_scene_to_file("res://main.tscn")



var to_talk = "none"

var interact = false

func _input(event):
	if event.is_action_pressed("interact"):interact=true
	if event.is_action_pressed("debug"):data.grade_points-=1



func dotalk():
	interact = false
	if !started:return
	if is_grade_scene && !triggered_olin:return
	
	if is_talking():
		if statement.text != statement.displayed_text:
			statement.instant_finish = true
	elif place == "home":
		if is_collide(yandy_collide):
			talk_yandel()
		elif is_collide(coffee_collide):
			print(data.inventory)
			to_talk="misc"
			var resp
			var options = ["yes","no","take a cup"]
			for i in data.inventory:
				if i == "poop pills":
					options.append("no, add poop pills")
					break
			if data.coffees_drank == 0:
				resp = await say("You found Coffee. Drink it? (temporary run speed boost)", options)
			elif data.coffees_drank < 2:
				resp = await say("Drink more? (you get more speed the more coffees you've drank)", options)
			else:
				resp = await say("Drink more?", options)
			if resp == 0:			
				play_sound("res://assets/items/minecraft-drinking-sound-effect.mp3")
				if data.coffee_has_drugs:
					play_sound("res://assets/cutscenes/untitled.ogg")
				coffee_effect = coffee_effect_length
				data.coffees_drank+=1
			elif resp == 2:
				add_to_inventory("coffee")
			elif resp == 3:
				play_sound("res://assets/items/splash.mp3")
				data.coffee_has_drugs = true
				var new_inv = []
				var got_rid_of_drug = false
				for i in data.inventory:
					if got_rid_of_drug || i!="poop pills":
						new_inv.append(i)
						got_rid_of_drug = true
						break
				data.inventory = new_inv
		elif is_collide(vicdraweria_collide):
			vicdraweria_talk()
		elif is_collide(c_collide):
			c_talk()
		elif is_collide(mcglee_collide):
			print("talk to mcglee")
			mcglee_talk()
		elif is_collide(gym_collide):
			to_talk = "gym"
			if !data.met_gym:
				data.met_gym = true
				await say("Hey, my name is Howlead. Here you can exercise to increase strength. It'd help in a battle... not that that would happen...")
			else:
				if await say("Do you want to train?", ["yes", "no"]) == 0:train()
				else:await say("Goodbye!")
		elif is_collide(bully_collide):
			to_talk="bully"
			var resps = ["Oh, no!"]
			if inventory_has("pencil"):
				resps.append("Stab bully with pencil")
			var resp = await say("Mwahaha, I'm gonna steal your money!", resps)
			if resp == 0:
				var to_say = "Good thing you "
				if inventory_has("pencil"):to_say+="didn't stab me with that pencil! "
				else: to_say+="don't have a pencil to stab me with! "
				to_say+="Now to take your money! "
				if data.money<5:to_say+="... ah... you don't have money. Welp, bye!"
				else: 
					to_say+="Say goodbye to $5!"
					data.money-=5
				await say(to_say)
			else:
				play_sound("res://assets/bully/scream.mp3")
				delete_from_inventory("pencil")
				await say("ARGHHHAHHHAHHAHHA!!! (you stole $5)")
				data.money+=5
				
		elif is_collide(myr_collide):
			to_talk = "myr"
			var resp
			if !data.met_myr:
				data.met_myr=true
				resp = await say("I'm Mr. MyRawrs. UwU.", ["UwU", "Can I do a test?"])
			else:
				resp = await say("Hi", ["UwU", "Can I do a test?"])
			if resp == 1:
				await say("Sure!")
				sentences_minigame = "math"
				get_tree().change_scene_to_file("res://Cutscenes/ks_work.tscn")
		elif is_collide(road_collide):
			to_talk = "misc"
			var r = await say("Do you want to go to your house?", ["yes", "no"])
			if r == 0:
				get_tree().change_scene_to_file("res://house.tscn")
		elif is_collide(road2_collide):
			to_talk = "misc"
			var r = await say("Do you want to go back to school?", ["yes", "no"])
			if r == 0:
				get_tree().change_scene_to_file("res://main.tscn")
		elif is_collide(bed_collide):
			to_talk = "misc"
			var r = await say("Do you want to take a nap?", ["yes", "no"])
			if r == 0:
				data.health = 100
				await say("you took a nap; health restored.")
		elif is_collide(karisan_collide):
			to_talk="karisan"
			if !data.karisan_alive:
				to_talk="misc"
				if 0==await say("What do you want to do?", ["pick up the body", "leave"]):
					add_to_inventory("karisan")
					data.got_karisan_body = true
				return
			const want_coffee = "Do you want some coffee?"
			var options = ["Hewwo", "I farded", "Can I do a sentence quiz?"]
			if inventory_has("coffee"):options.append(want_coffee)
			var r = await say("Are you so ready to hear the learning targets so you can learn how to succeed beyond your wildest dreams?", options)
			if r == 0:
				await say("Hey, kid. Get out of my sight.")
			elif r == 1:
				await say("Total fail. Try harder, kid.")
			elif r == 2:
				if await say("You wanna do a sentence quiz?", ["yeah", "no"]) == 0:
					sentences_minigame = "ELA"
					get_tree().change_scene_to_file("res://Cutscenes/ks_work.tscn")
			elif r == 3:
				await say("Sure; thanks, kid!")
				play_sound("res://assets/items/minecraft-drinking-sound-effect.mp3")
				delete_from_inventory("coffee")
				if data.coffee_has_drugs:
					play_sound("res://assets/cutscenes/untitled.ogg")
					await say("ARRRGHHHH!! *poops self*")
					to_talk = "misc"
					await say("Karisan died of vowel movements")
					data.karisan_alive = false
				else:await say("That was great, good thing it didn't have laxitives!")
			
		elif is_collide(pencil_collide):
			to_talk = "misc"
			var r = await say("Pick up the pencil?", ["yes","no"])
			if r == 0:
				add_to_inventory("pencil")
				print("added pencil")
				print(data.inventory)	
		elif is_collide(meat_collide):
			to_talk="meat"
			var r = await say("Hello, I'm Meatchal Derosin. What may I do for you?", ["Nothing", "Could I have some laxitives?"])
			if r == 0:
				await say("Very well; I shall see you soon, child")
			elif r == 1:
				await say("Indeed, here you are")
				add_to_inventory("poop pills")
		elif is_collide(trash_collide):
			to_talk = "misc"
			var options = data.inventory.duplicate()
			options.append("Nothing")
			var r = await say("What item do you want to throw away?", options)
			if r >= len(data.inventory):
				return
			play_sound("res://assets/items/garbage.mp3")
			delete_from_inventory(data.inventory[r])
		elif is_collide(loreinc_collide):
			to_talk = "loreinc"
			if 1 == await say("Hewwow (UwU)", ["UwU", "Can I do a test?"]):
				sentences_minigame = "spanish"
				get_tree().change_scene_to_file("res://Cutscenes/ks_work.tscn")
		elif is_collide(computer_collide):
			get_tree().change_scene_to_file("res://computer.tscn")
		elif is_collide(airplane_collide):
			to_talk = "misc"
			data.seen_plane = true;
			await say("This is an airplane. It says \"Mr. McGlee's Aierplayne\". Interesting...")
func vicdraweria_talk():
	to_talk = "vicdrawer"
	var response = await say("Greetings, fellow! I'm Vicdraweria, what would you like me to do?", ["How much money do I have?"])
	if response == 0:
		await say("You've got $" + str(data.money) + ".")
func delete_from_inventory(item):
	var new_inv = []
	var x = 0
	var already_removed = false
	while x < len(data.inventory):
		if data.inventory[x] != item || already_removed:
			new_inv.append(data.inventory[x])

		elif data.inventory[x] == item:
			already_removed=true
		x+=1
	data.inventory = new_inv
func add_to_inventory(item):
	if len(data.inventory) >4:
		await say("inventory is full; throw something away in the trash can.")
	else:
		data.inventory.append(item)
	
func inventory_has(item):
	for i in data.inventory:
		if i == item:return true
	return false
func is_collide(obj):
	if obj == null:
		return false
	var response = obj.get_overlapping_bodies()
	#print("collide")
	#print(typeof(response))
	if typeof(response) != 28:return false
	for collision in response:
		if collision == player:
			return true
	return false


func mcglee_talk():
	to_talk = "mcglee"
	var resps = ["Hi!", "What's my grade?", "Can I get into the room behind you?"]
	if data.seen_plane:
		resps.append("What's with the plane outside?")
	var resp
	if !data.met_mcglee:
		data.met_mcglee = true
		resp = await say("Hi, I'm Mr. McGlee!", resps)
	else: resp = await say("Hi!", resps)
	if resp == 1:
		if !data.mcglee_explained:
			data.mcglee_explained = true
			await say("You've got a grade of " + str(get_grade()) + "%. Be careful, if your grade gets too low, you'll drop out, and be poor and sad for the rest of your life. UwU.")
		else:await say("You've got a grade of " + str(get_grade()) + "%.")
	if resp == 2:
		await say("No.")
	if resp==3:
		if await say("It's mine. Wanna fly in it?", ["No","Yea"]) == 1:
			get_tree().change_scene_to_file("res://aviator_ending.tscn")
		
	
func get_grade():return round((data.grade_points/data.total_grade_points) * 100)
func c_talk():
	to_talk = "mr c"
	if !data.met_c:
		data.met_c=true
		var resp = await say("I'm mister CeOwOha... w-what's your name...?", ["I don't like you", "I'm your worst nightmare", "I don't know", "UwU"])
		if resp == 0:
			await say("That's mean!")
			data.c_love -= 2
		elif resp == 1:
			await say("Oh no! >~< t-t-that's scawie (」゜ロ゜)」")
			data.c_love -= 8
		elif resp == 2:
			await say("You should probably know by now...")
		else:
			await say("UwU")
			data.c_love+=3
	else:
		if data.c_love <= c_hate:
			await say("I.. I don't wanna talk 2 u 😞😞😞")
			return
		var resp = 0
		if !data.yandy_love<=-10:
			resp = await say("Hello!", ["Can I do some work?", "I hate you", "I wuv you (UwU)"])
		else:
			resp = await say("Hello!", ["Can I do some work?", "I hate you", "I wuv you (UwU)", "I hate Yandol"])
		if resp == 0:
			if !data.mcglee_explained:
				await say("You should talk to Mr. McGlee about your grade first.")
			else:
				started=false
				get_tree().change_scene_to_file("res://Cutscenes/games/mr_c_game.tscn")
		elif resp == 1:
			data.c_love-=5
			await say("That's m-m-mean!")
		elif resp == 2:
			data.c_love+=3
			await say("I wuv you too")
		else:
			data.c_love-=1
			data.yandy_love-=5
			await say("don't you think that's mean to Yandol?")

func train():
	get_tree().change_scene_to_file("res://Cutscenes/basketball.tscn")

var owolin_damage = 10

func hurt(pain):
	play_sound("res://assets/cutscenes/oof.mp3")
	data.health-=pain

func olin_talk():
	print(started)
	var r
	to_talk = "olin"
	play_sound("res://assets/charecter_assets/olin/owolin_laugh.mp3")
	r = await say("well, well, well, who have we here?")
	var resp = await say("A fine specimin for experimentation...", ["Fight", "Wait"])
	if resp == 0:
		boss_health = 100
		while true:
			to_talk = "misc"
			r = await say("what do you want to do?", ["Punch (" + str(data.strength) + " damage)", "wait"])
			if r == 0:
				boss_health-=data.strength
				print("boss health: " + str(boss_health))
				if boss_health<=0:
					await say ("You Win; Owolin is defeated.")
					get_tree().change_scene_to_file("res://Cutscenes/freedom.tscn")
					return
				await say("you did " + str(data.strength) + " damage (equal to your strength). He's now at " + str(boss_health) + " health")
			hurt(owolin_damage)
			r = await say("OwOlin did " + str(owolin_damage) + " damage.")
			if data.health <=0:
				await say("You lose")
				get_tree().change_scene_to_file("res://Cutscenes/unscheduled_disection.tscn")
	elif data.yandy_love > 10:
		to_talk = "misc"
		await say("yandy saves you!")
	else:
		to_talk = "misc"
		await say("You wait, but no one comes to save you. Maybe try talking to some people next time? Maybe Yandol?")
		get_tree().change_scene_to_file("res://Cutscenes/unscheduled_disection.tscn")





func _physics_process(delta):

	if olin_hitbox != null && has_drama && is_collide(olin_hitbox) && !triggered_olin:
		triggered_olin = true
		olin_talk()
	if interact:
		dotalk()
	if is_dead || is_grade_scene || triggered_olin:
		return
	if updatebbscore:
		to_talk = "misc"
		data.strength+=bbscore
		updatebbscore = false
		await say("you gained "+str(bbscore)+" strength. You now have " + str(round(data.strength)) + " strength.")
		return


			
		
	if get_grade()<50:
		get_tree().change_scene_to_file("res://Cutscenes/grade_too_low.tscn")
		has_drama = true
		is_grade_scene = true
	var can_interact_temp = false
	for item in [coffee_collide, yandy_collide, c_collide, 
	mcglee_collide, gym_collide, myr_collide, road_collide, road2_collide, 
	bed_collide, karisan_collide, pencil_collide, meat_collide, trash_collide, 
	loreinc_collide, computer_collide, vicdraweria_collide, bully_collide,
	airplane_collide]:
		if is_collide(item):
			can_interact_temp = true
			break
	can_interact = can_interact_temp
	
	if data.yandy_love <= yandy_love_death:
		is_dead = true
		get_tree().change_scene_to_file("res://Cutscenes/yandel_murder.tscn")
	if data.yandy_love <= yandy_hate && data.c_love <= c_hate:
		is_dead = true
		get_tree().change_scene_to_file("res://Cutscenes/no_love.tscn")
	coffee_effect-=delta
	if coffee_effect>0:
		camera_shake_amount=coffee_strength+(more_coffee_mul*data.coffees_drank*5)
		shake_camera = true
		player_run_speed_mul=coffee_strength+(more_coffee_mul*data.coffees_drank)
	else:
		camera_shake_amount = 3
		shake_camera = false
		player_run_speed_mul=standard_run_mul
	player_run_speed = player_normal_speed * player_run_speed_mul
	if data.coffees_drank >= death_coffee:
		is_dead = true
		get_tree().change_scene_to_file("res://Cutscenes/coffee_death.tscn")
	step_play_interval_run = step_play_interval_normal/(player_run_speed/player_normal_speed)
	
func talk_yandel():
	to_talk = "yandel"
	if !data.met_yandel:
		print("aaaaaaaaaaaaaaaaaaa")
		sounds_to_play.append("res://assets/voice/hello.mp3")
		data.met_yandel = true
		var resp = await say("Hewwow >~< welcome to cOwOmbia High School 😖, I'm Yandol ^w^", ["Nice to meet you", "Die in a hole", "ok"])
		
		if resp == 0:
			data.yandy_love+=5
			await say("N-Nice to meet you too, baka 😊")
			
		elif resp == 1:
			data.yandy_love-=6
			await say("(yandol will remember that)")
	elif data.yandy_love >= -10:
		sounds_to_play.append("res://assets/voice/hello.mp3")
		var resp = await say("Hi", ["Hewwo", "hi", "I don't like you."])
		if  resp == 0:
			await say("Thanks >~<")
			print("was nice")
			data.yandy_love+=2
		elif resp == 2:
			await say("Ur mean 😔")
			print("was mean")
			data.yandy_love-=6
	else:
		await say("I don't want to talk to you ( ͡° ʖ̯ ͡°)")
func is_talking():return statement.talking != "none"
func make_new_message(text, options=[]):
	statement.talking = to_talk
	if len(options) > 0:
		statement.options = options
	else:
		statement.options = ["..."]
	statement.displayed_text = ""
	if statement.talking == "yandel":
		statement.text = "Yandol: "
		statement.displayed_text = "Yandol: "
	if statement.talking == "mr c":
		statement.text = "CeOwOha: "
		statement.displayed_text = "CeOwOha: "
	if statement.talking == "mcglee":
		statement.text = "McGlee: "
		statement.displayed_text = "McGlee: "
	if statement.talking == "olin":
		statement.text = "OwOin: "
		statement.displayed_text = "OwOin: "
	if statement.talking == "gym":
		statement.text = "Howlead: "
		statement.displayed_text = "Howlead: "
	if statement.talking == "olin":
		statement.text = "Owolin: "
		statement.displayed_text = "Owolin: "
	if statement.talking == "myr":
		statement.text = "MyRawrs: "
		statement.displayed_text = "MyRawrs: "
	if statement.talking == "karisan":
		statement.text = "Kari San: "
		statement.displayed_text = "Kari San: "
	if statement.talking == "meat":
		statement.text = "Meatchal: "
		statement.displayed_text = "Meatchal: "
	if statement.talking == "loreinc":
		statement.text = "Sr. Lore, Inc.: "
		statement.displayed_text = "Sr. Lore, Inc.:"
	if statement.talking == "vicdrawer":
		statement.text = "Vicdraweria: "
		statement.displayed_text = statement.text
	if statement.talking == "bully":
		statement.text = "Bully: "
		statement.displayed_text = statement.text
	statement.text+=text
var responded = -1
func say(text, options=[]):
	make_new_message(text, options)
	while true:
		await get_tree().create_timer(0.1).timeout
		if responded != -1:
			var rspd_tmp = responded
			responded = -1
			return rspd_tmp		
func pressed_response(button_number):
	print(statement.options[button_number])
	statement.instant_finish = false
	statement.response=button_number
	statement.text = ""
	statement.displayed_text = ""
	var was_talking = statement.talking
	responded=button_number
	statement.talking = "none"	
func play_random_sound(sounds):
	var file_to_play = sounds[randi_range(0,len(sounds)-1)]
	play_sound(file_to_play)
func play_sound(sound):sounds_to_play.append(sound)
