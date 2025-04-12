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

var friends = {
	"bob": false,
	"doggo":false,
	"pooper_5000":false,
	"janet":false,
	"doug":false
}

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
