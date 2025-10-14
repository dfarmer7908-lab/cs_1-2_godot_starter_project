extends CharacterBody2D

var start_timer = 2
var timer = start_timer
var maxHealth = 10
var health = maxHealth

func change_health(_amount:int):
		health += _amount
		if health < 1:
			die()
		if health > maxHealth:
			health = maxHealth
		print("Health: ", health)
		
func die():
	print("minotaur died")
