extends CharacterBody2D

const mov_speed = 0.1
var mov_cur = 0
var mov_state = "left"
var mov_state_state = 0



const char_images = {
	"up":[8,9,10,11],
	"down":[4,5,6,7],
	"left":[0,1,2,3],
	"right":[12,13,14,15]
}

var main = null
var current_step_progres = 0
var camera = null
var random = RandomNumberGenerator.new()


func _ready():
	main = get_node("/root/MainScript")
	main.player = get_node(".")
	animation = get_node("texture")
	camera = get_node("camera")
	var interact_button = get_node("camera/greenbox/Button")
	interact_button.pressed.connect(enable_interact)
	if main.is_mobile:
		get_node("camera/movedown").show()
		get_node("camera/moveup").show()
		get_node("camera/moveleft").show()
		get_node("camera/moveright").show()
		get_node("camera/space").text = "click here to interact"

	


var move_up = false
var move_down = false
var move_right = false
var move_left = false
func set_move_x(mov):
	if mov == 1:
		move_up = true
		move_down = false
	if mov == 0:
		move_up = false
		move_down = false
	if mov == -1:
		move_down = true
		move_up = false
func set_move_y(mov):
	if mov == 1:
		move_left = true
		move_right = false
	if mov == 0:
		move_left = false
		move_right = false
	if mov == -1:
		move_right = true
		move_left = false

func _input(event):
	if event.is_action_pressed("up"):
		set_move_x(1)
	if event.is_action_pressed("down"):
		set_move_x(-1)
	if event.is_action_released("up") || event.is_action_released("down"):
		set_move_x(0)
	if event.is_action_pressed("left"):
		set_move_y(1)
	if event.is_action_pressed("right"):
		set_move_y(-1)
	if event.is_action_released("left") || event.is_action_released("right"):
		set_move_y(0)
	
func enable_interact():main.interact = true
	
	
func render_inventory():
	for count in range(0,5):
		var thing = get_node("Hotbar/b"+str(1+count))
		if count >= len(main.data.inventory):thing.texture_normal = null
		elif main.data.inventory[count] == "pencil":thing.texture_normal = load("res://assets/items/pencil_small.webp")
		elif main.data.inventory[count] == "poop pills":thing.texture_normal = load("res://assets/items/lax.webp")
		else:thing.texture_normal = null
	
var animation = null
var direction = char_images.down
func _physics_process(delta):
	render_inventory()
	get_node("camera/hp").text = "Health: " + str(main.data.health) + "%"
	if main.shake_camera:
		camera.set_offset(Vector2( 
			random.randi()%main.camera_shake_amount-main.camera_shake_amount/2,
			random.randi()%main.camera_shake_amount-main.camera_shake_amount/2 
		))
	else:
		if camera.get_offset() != Vector2(0,0):camera.set_offset(Vector2(0,0))	
	if main.is_talking():
		pass
	else:
		var speed = main.player_normal_speed
		var  is_walking = false
		if Input.is_action_pressed("run"):
			speed = main.player_run_speed
		var previmg = direction
		if move_up || get_node("camera/moveup").is_pressed():
			velocity.y -= speed*delta
			direction=char_images.up
			is_walking = true
			mov_state = "up"
		elif move_down || get_node("camera/movedown").is_pressed():
			velocity.y += speed*delta
			is_walking = true
			direction=char_images.down
			mov_state = "down"
		if move_left || get_node("camera/moveleft").is_pressed():
			velocity.x -= speed*delta
			direction=char_images.left
			mov_state = "left"
			is_walking = true
		elif move_right || get_node("camera/moveright").is_pressed():
			velocity.x += speed*delta
			direction=char_images.right
			is_walking = true
			mov_state = "right"
		if is_walking:
			mov_cur+=delta
			if mov_speed < mov_cur:
				mov_cur=0
				mov_state_state+=1
			if len(char_images[mov_state])<= mov_state_state:mov_state_state=0
			animation.frame = char_images[mov_state][mov_state_state]
			current_step_progres+=delta
			if speed == main.player_normal_speed:
				while current_step_progres>=main.step_play_interval_normal:
					current_step_progres -=main.step_play_interval_normal
					main.play_random_sound([
						"res://assets/footsteps/GiocoSound.mp3",
						"res://assets/footsteps/d00121058.mp3",
						"res://assets/footsteps/jsk.mp3",

					])
			else:
				while current_step_progres>=main.step_play_interval_run:
					current_step_progres-=main.step_play_interval_run
					main.play_random_sound([
						"res://assets/footsteps/GiocoSound.mp3",
						"res://assets/footsteps/d00121058.mp3",
						"res://assets/footsteps/jsk.mp3",
					])

		move_and_slide()
		velocity.x+=-velocity.x * main.player_friction * delta
		velocity.y+=-velocity.y * main.player_friction * delta
		if main.can_interact && !main.has_drama:
			get_node("camera/space").show()
			get_node("camera/greenbox").show()
		else:
			get_node("camera/space").hide()
			get_node("camera/greenbox").hide()
		

