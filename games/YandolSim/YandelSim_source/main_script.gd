extends Node
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

var has_drama = false
var place = "home"
var yandy_collide = null
var gym_collide = null
var yandy_hate = -10
var c_hate =     -10
const death_coffee = 5
var strength = 0
var strength_for_olin = 5
var is_grade_scene = false
var grade_scene_time = 0
var player = null
var c_collide = null
var mcglee_collide = null
var coffee_collide = null
var road_collide = null
var olin_hitbox = null
var is_in_olin_scene = true

var coffee_effect = 0
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




var shake_camera = false

const garbage_collect_interval = 0.5
var sounds_to_play = []


func _ready():
	pass

const default_data = {
		"yandy_love":0,
		"c_love":0,
		"misc_action":"",
		"coffees_drank":0,
		"grade_points": 5.0,
		"total_grade_points": 10.0,
		"met_myr":false,
		"strength":0.0,
		
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
		
		"inventory":[]
	}
	
var persistant_data = {}

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
			to_talk="misc"
			var resp
			if data.coffees_drank == 0:
				resp = await say("You found Coffee. Drink it? (temporary run speed boost)", ["yes", "no"])
			elif data.coffees_drank < 2:
				resp = await say("Drink more? (you get more speed the more coffees you've drank)", ["yes", "no"])
			else:
				resp = await say("Drink more?", ["yes", "no"])
			if resp == 0:			
				play_sound("res://assets/items/minecraft-drinking-sound-effect.mp3")
				coffee_effect = coffee_effect_length
				data.coffees_drank+=1
		elif is_collide(c_collide):
			c_talk()
		elif is_collide(mcglee_collide):
			print("talk to mcglee")
			mcglee_talk()
		elif is_collide(gym_collide):
			print("gym guy talk")
			gym_guy_talk()
		elif is_collide(myr_collide):
			print("myr talk")
			myr_talk()
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
			var r = await say("Hello, sir!", ["Hi", "I farded", "asdasdsad", "fart", "poop", "yeet"])
			if r == 1:
				await say("OMG; I happen to also have commited a fard.")
		elif is_collide(pencil_collide):
			to_talk = "misc"
			var r = await say("Pick up the pencil?", ["yes","no"])
			if r == 0:
				add_to_inventory("pencil")
				print("added pencil")
				print(data.inventory)				
func add_to_inventory(item):
	if len(data.inventory) >4:
		await say("inventory is full; throw something away in the trash can.")
	else:
		data.inventory.append(item)
	
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
	var resp
	if !data.met_mcglee:
		data.met_mcglee = true
		resp = await say("Hi, I'm Mr. McGlee!", ["Hi!", "What's my grade?", "Can I get into the room behind you?"])
	resp = await say("Hi!", ["Hi!", "What's my grade?", "Can I get into the room behind you?"])
	if resp == 1:
		if !data.mcglee_explained:
			data.mcglee_explained = true
			await say("You've got a grade of " + str(get_grade()) + "%. Be careful, if your grade gets too low, you'll drop out, and be poor and sad for the rest of your life. UwU.")
		else:await say("You've got a grade of " + str(get_grade()) + "%.")
	if resp == 2:
		await say("No.")
func myr_talk():
	to_talk = "myr"
	if !data.met_myr:
		data.met_myr=true
		say("I'm Mr. MyRawrs. UwU.")
	else:
		say("Hi")
		
	
func get_grade():
	return round((data.grade_points/data.total_grade_points) * 100)
func c_talk():
	to_talk = "mr c"
	if !data.met_c:
		data.met_c=true
		var resp = await say("I'm mister CeOwOha... w-what's your name...?", ["I don't like you", "I'm your worst nightmare", "I don't know", "UwU"])
		if resp == 0:
			say("That's mean!")
			data.c_love -= 2
		elif resp == 1:
			say("Oh no! >~< t-t-that's scawie (」゜ロ゜)」")
			data.c_love -= 8
		elif resp == 2:
			say("You should probably know by now...")
		else:
			say("UwU")
			data.c_love+=3
	else:
		if data.c_love <= c_hate:
			say("I.. I don't wanna talk 2 u 😞😞😞")
			return
		var resp = 0
		if !data.yandy_love<=-10:
			resp = await say("Hello!", ["Can I do some work?", "I hate you", "I wuv you (UwU)"])
		else:
			resp = await say("Hello!", ["Can I do some work?", "I hate you", "I wuv you (UwU)", "I hate Yandol"])
		if resp == 0:
			if !data.mcglee_explained:
				say("You should talk to Mr. McGlee about your grade first.")
			else:
				started=false
				get_tree().change_scene_to_file("res://Cutscenes/games/mr_c_game.tscn")
		elif resp == 1:
			data.c_love-=5
			say("That's m-m-mean!")
		elif resp == 2:
			data.c_love+=3
			say("I wuv you too")
		else:
			data.c_love-=1
			data.yandy_love-=5
			say("don't you think that's mean to Yandol?")
func gym_guy_talk():
	to_talk = "gym"
	if !data.met_gym:
		data.met_gym = true
		say("Hey, my name is (GYMGUYNAME). Here you can exercise to increase strength. It'd help in a battle... not that that would happen...")
	else:
		var resp = await say("Do you want to train?", ["yes", "no"])
		if resp == 0:
			train()
		else:
			say("Goodbye!")
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
				await say("you did " + str(data.strength) + " damage (equal to your strength). He's now at " + str(boss_health) + " health")
			hurt(owolin_damage)
			r = await say("OwOlin did " + str(owolin_damage) + " damage.")
		
		#if data.strength >= 20:
		#	r = await say("You defeated OwoOin.")
		#	get_tree().change_scene_to_file("res://Cutscenes/freedom.tscn")
		#else:
		#	r = await say("You lost.")
		#	r = await say("If only you had 20 or more strength...")
		#	get_tree().change_scene_to_file("res://Cutscenes/unscheduled_disection.tscn")
	else:
		pass




var triggered_olin = false
func _physics_process(delta):
	if is_dead:
		return
	if olin_hitbox != null && has_drama && is_collide(olin_hitbox) && !triggered_olin:
		triggered_olin = true
		olin_talk()
	if interact:
		dotalk()
	if is_grade_scene || !started:
		return


	time_since_start+=delta
	if time_since_start<2:
		return
	if updatebbscore:
		to_talk = "misc"
		data.strength+=bbscore
		updatebbscore = false
		say("you gained "+str(bbscore)+" strength. You now have " + str(round(data.strength)) + " strength.")
		return


			
		
	if get_grade()<50:
		get_tree().change_scene_to_file("res://Cutscenes/grade_too_low.tscn")
		has_drama = true
		is_grade_scene = true
		return
	var can_interact_temp = false
	for item in [coffee_collide, yandy_collide, c_collide, mcglee_collide, gym_collide, myr_collide, road_collide, road2_collide,
	bed_collide, karisan_collide, pencil_collide]:
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
			say("N-Nice to meet you too, baka 😊")
			
		elif resp == 1:
			data.yandy_love-=6
			say("(yandol will remember that)")
	elif data.yandy_love >= -10:
		sounds_to_play.append("res://assets/voice/hello.mp3")
		var resp = await say("Hi", ["Hewwo", "hi", "I don't like you."])
		if  resp == 0:
			say("Thanks >~<")
			print("was nice")
			data.yandy_love+=2
		elif resp == 2:
			say("Ur mean 😔")
			print("was mean")
			data.yandy_love-=6
	else:
		say("I don't want to talk to you ( ͡° ʖ̯ ͡°)")


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
		statement.text = "Gym guy: "
		statement.displayed_text = "Gym guy: "
	if statement.talking == "olin":
		statement.text = "Owolin: "
		statement.displayed_text = "Owolin: "
	if statement.talking == "myr":
		statement.text = "MyRawrs: "
		statement.displayed_text = "MyRawrs: "
	if statement.talking == "karisan":
		statement.text = "Kari San: "
		statement.displayed_text = "Kari San: "
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
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

				
