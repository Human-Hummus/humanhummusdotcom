extends Node

var poops = 0
var max_poops = 100
var money = 0

var crops = {
	"wheat": {
		"sells": 1,
		"requires":100,
		"persecond":0.5
	}
	
}

var friends = [
	{
		"name": "bob",
		"owned": false,
		"cost": 5,
		"pps": 3,
		"image": preload("res://friends/friends/bob.png")
	},
	{
		"name": "doggo",
		"owned": false,
		"cost": 10,
		"pps": 6,
		"image": preload("res://friends/friends/doggo.png")
	}
]

func try_buy(amt):
	if money>=amt:
		money-=amt
		return true
	else:
		return false

func add_money(amt):
	money+=amt
func add_poop(amt):
	if poops + amt > max_poops:
		return
	poops+=1
