extends Node2D
const turret_projectile = preload("res://scenes/turret_projectile.tscn")

# TODO: Add variables for turret state
# Track if player is in range, projectile scene, etc.
# Look at "Boolean Variables and State Tracking" documentation

# TODO: Add projectile scene variable
# Look at "Reusing Projectile Systems" documentation

func _ready():
	# TODO: Set up shooting timer
	# Look at "Working with Timers" documentation
	pass

func _on_detection_area_body_entered(body):
	# TODO: Check if the body is the player
	# Update player detection state
	# Look at "Boolean Variables and State Tracking" documentation
	if body.name == "Player":
		var new_projectile = turret_projectile.instantiate()
		get_parent().add_child(new_projectile)
		new_projectile.set_direction(body.position)
		var turret_projectile = preload("res://scenes/turret_projectile.tscn")
		new_projectile.global_position = position + Vector2(0,-25)




	# TODO: Check if the body is the player  
	# Update player detection state
	# Look at "Boolean Variables and State Tracking" documentation
	pass

func _on_shooting_timer_timeout():
	# TODO: Check if player is in range
	# If yes, shoot at player
	# Look at documentation for shooting logic
	pass

func shoot_at_player():
	# TODO: Get player's current position
	# Calculate direction from turret to player
	# Create and launch projectile
	# Look at "Getting Object Positions", "Direction Calculation", 
	# and "Reusing Projectile Systems" documentation
	
		
	pass
