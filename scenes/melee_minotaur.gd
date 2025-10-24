extends CharacterBody2D

var maxHealth = 5
var health = maxHealth
var starttime = .67
var timer = starttime

func _process(delta: float):
	timer -= delta
	
func change_health(_amount:int):
		if timer < 0:
			health += _amount
			print("minotaur health: ", health)
			timer = starttime
		if health < 1:
			die()
		if health > maxHealth:
			health = maxHealth
		
		
func die():
	queue_free()
	print("minotaur died")
