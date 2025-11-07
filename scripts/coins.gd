extends Node


func _on_body_entered(body):
	if body.name == "CharacterBody2D":
	# TODO: Check if the object that touched the coin is the player
		body.change_coins(1)
		queue_free()
		
	
		var coins = 0
		coins = coins+1
		coins+=1
	
	# TODO: Remove the coin from the game
	
	
