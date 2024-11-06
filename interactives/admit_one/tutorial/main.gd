extends Node2D

var dialogue
var audio
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue = get_node("dialogue")
	audio =get_node("Audio")
	
func p(audio_name):
	audio.stop()
	audio.stream = load("res://tutorial/Audio/"+audio_name+".mp3")
	audio.seek(0.0)
	audio.play()
	
var sp = 0
var dia_thing = 1
func _process(delta: float) -> void:
	sp+=delta
	if !(dia_thing>1) && sp>=1:
		dialogue.say_stuff("??? > ...")
		dia_thing+=1
	if Input.is_action_just_pressed("ui_accept"):
		if dia_thing == 2:
			dia_thing+=1
			dialogue.say_stuff("??? > .....")
		elif dia_thing == 3:
			dia_thing+=1
			dialogue.say_stuff("??? > …….. *poke, poke*")
		elif dia_thing == 4:
			dia_thing+=1
			dialogue.say_stuff("??? > *sigh*")
			p("sigh")
		elif dia_thing == 5:
			dia_thing+=1
			dialogue.say_stuff("??? > UP AND AT ‘EM, YA WAFFLE SNIFFER!!!")
			get_node("Bg1").show()
			get_node("Susd").show()
			p("waffle_sniffer")
		elif dia_thing == 6:
			dia_thing+=1
			dialogue.say_stuff("??? > Sleep is for people who are unemployed, and you, my friend, have a job to do!")	
			p("sleep_unemployed")
		elif dia_thing == 7:
			dia_thing+=1
			dialogue.say_stuff("??? > Now this might be a bit alarming considering you didn’t apply for this job, or walk into this building, or live in this state…")
			p("alarming")
		elif dia_thing == 8:
			dia_thing+=1
			dialogue.say_stuff("??? > But just stay still and I promise I’ll explain everything!")
			p("staystill")
		elif dia_thing == 9:
			dia_thing+=1
			dialogue.say_stuff("??? > Or well I guess you can’t really move yet… My bad, I’ll just give you the deets and you’ll probably be untied by lunch break.")
			p("guessyacantmove")
		elif dia_thing == 10:
			dia_thing+=1
			dialogue.say_stuff("??? > Aight I’m gonna rapid fire some tasks at ya’, so you better listen carefully. Starting with the most important part- my name!")
			p("rapidfire")
		elif dia_thing == 11:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > I’m the Sussy Wussy Ducky, or DuckBot for your purposes. I’ll be your guide for today.")
			p("duckbot")		
		elif dia_thing == 12:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > So here’s the situation: the boss is a bit low on moola and a bakery ain’t gonna roll in the dough.")
			p("moola")
		elif dia_thing == 13:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > And what better side hustle then to have thousands of impressionable kids willing to spend fortunes!")
			p("spendplz")
		elif dia_thing == 14:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > For a mediocre lecture completely unaware of the financial implications?")
			p("implications")
		elif dia_thing == 15:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > Right now we’re just a small community college...")
			p("comcol")
		elif dia_thing == 16:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > But with your hard effort I’m sure we can become one of them oak league schools!")
			p("oakle")
		elif dia_thing == 17:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > But we can’t exactly cash in the tuition if we don’t have any students… so that’s where you come in, honorable admissions office!")
			get_node("computer").show()
			get_node("computer").can_press = false
			get_node("computer").new_application(main.new_app())
			p("wyci")
		elif dia_thing == 18:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > Yeah, sorry. We would have actually just hired someone but we maybe, kinda,")
			p("yeahsorry")
		elif dia_thing == 19:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > spent perhaps all of our budget on our sports program? I’m sure you’ll figure it out. ")
			p("perhaps")
		elif dia_thing == 20:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > The job is simple, you get an application, and you either accept or reject it")
			p("jobsimple")
		elif dia_thing == 21:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > Like this!")
			get_node("computer").reject()
			p("lt")
		elif dia_thing == 22:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > Oh was that an actual application? Erm, I hope it wasn’t a good one. Oh well, it’s your job not mine.")
			p("yourjob")
		elif dia_thing == 23:
			dia_thing+=1
			#get_node("computer").hide()
			dialogue.say_stuff("DuckBot > The type of students you accept will affect our stats, y’know, what we’re known for and our average gpa and all.")
			p("typeostud")
		elif dia_thing == 24:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > Maybe you only accept a certain type and we specialize into like a STEM school or something,")
			p("mayb")
		elif dia_thing == 25:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > so be careful we don’t become something silly like a business school. You can check how we’re doing on our homepage.")
			p("carful")
		elif dia_thing == 26:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > Maybe you can edit the homepage- there’s no need to take it seriously!")
			p("edits")
		elif dia_thing == 27:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > Speaking of that- don’t forget you’re on your computer, take advantage of it!")
			p("speakingof")
		elif dia_thing == 28:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > Watch a video, go online shopping, play the Washington Times Crossword…")
			p("watchvideo")
		elif dia_thing == 29:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > Or well I mean you can do background checks on the potential students, look out for shady social media posts and what not.")
			p("whatnot")
		elif dia_thing == 30:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > In fact, since we can’t actually afford to pay you let alone multiple employees, you also get to handle the funds!")
			p("infact")
		elif dia_thing == 31:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > Just state how much of our income to go to each department. Or you know spend the school’s budget on personal shopping,")
			p("funds")
		elif dia_thing == 32:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > I think HumanHummus is releasing a new game for preorder soon.")
			p("humhum")
		elif dia_thing == 33:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > Oh, but be careful! The boss uses Blockci/te, which surprisingly isn’t a LEGO knockoff,")
			p("dontgetcaught")
		elif dia_thing == 34:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > but will close all “inappropriate” tabs and notify him that you were on them.")
			p("inap")
		elif dia_thing == 35:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > It only works within a certain proximity though, and trust me, you’ll definitely hear him coming.")
			p("proximity")
		elif dia_thing == 36:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > Ok, one last thing. If you need help or something or just wanna chat, I took the effort to add your contacts onto the app, Entropy.")
			p("onelastthing")
		elif dia_thing == 37:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > I saw lots of weird names and hearts but don’t worry! Did ya' a favor! Only included contacts that were just phone numbers!")
			p("hearts")
		elif dia_thing == 38:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > You can also text me if you want, but I won’t guarantee that I’ll reply.")
			p("textme")
		elif dia_thing == 39:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > Ok let’s see what’s left, housing, food, last known location of your family…")
			p("famiwy")
		elif dia_thing == 40:
			dia_thing+=1
			dialogue.say_stuff("DuckBot > yep I think I got all the important stuff! Aaa-nd you’re off! Go make us some money!")
			p("last")
