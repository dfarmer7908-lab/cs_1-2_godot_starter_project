extends CharacterBody2D
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D
const projectile_original = preload("res://scenes/projectile.tscn")


var xSpeed = 300.0
var xDirection = 0
var facing = "down"
var ySpeed = 300.0
var yDirection = 0

# TODO: Add health system variables
var health = 10
var maxHealth = 10

# TODO: Add projectile scene for shooting
# var projectile_scene = preload("res://scenes/projectile.tscn")

func _physics_process(_delta):
	# TODO: Get horizontal input (left/right keys)
	# Input.get_axis checks two keys and gives us a number:
	# - When LEFT is pressed: returns -1.0
	# - When RIGHT is pressed: returns 1.0  
	# - When NOTHING is pressed: returns 0.0
	xDirection = Input.get_axis("ui_left", "ui_right")
	
	
	# TODO: Get vertical input (up/down keys)  
	# Same idea, but for up and down movement
	yDirection = Input.get_axis("ui_up","ui_down")
	
	# TODO: Calculate X movement by multiplying direction × speed
	# This gives us the actual pixels to move this frame
	# If direction is 1 and speed is 300, we get 300 pixels right
	# If direction is -1 and speed is 300, we get -300 pixels (left)
	# Type this exactly: var velocity.y = xDirection * xSpeed
	velocity.x = xDirection * xSpeed
	
	# TODO: Calculate Y movement the same way
	 # Type this exactly: var velocity.y = yDirection * ySpeed  
	velocity.y = yDirection * ySpeed
	
	
	# TODO: Set the player's velocity (how fast they're moving)
	# Godot's CharacterBody2D uses a velocity system
	# Type this exactly: velocity.x = xVector
	
	
	# TODO: Set the Y velocity too
	# Type this exactly: velocity.y = yVector
	
	
	# TODO: Update facing direction based on movement
	# Use if statements to check xDirection and yDirection
	# Set facing to "right", "left", "down", or "up"
	# Only update facing when actually moving (direction != 0)
	if xDirection > 0:
		facing = "right"
	elif xDirection < 0:
		facing = "left"
	elif yDirection < 0:
		facing = "up"
	elif yDirection > 0:
		facing = "down"
	
	#if space is pressed:
	if Input.is_action_just_pressed("ui_select"):
		shoot() 
	
	# TODO: Update animation based on facing direction
	# Call your update_animation() function here
	update_animation()
	
	# TODO: Check for shooting input
	# Use: if Input.is_action_just_pressed("ui_accept"):
	# Then call your shoot() function
	
	
	# TODO: Actually apply the movement
	# This is a special Godot function that makes the movement happen
	move_and_slide()
	
	
	# TODO: Print confirmation that we moved
	# Type this exactly: print("Player moved!")


# TODO: Create animation function (add this outside of _physics_process)
func update_animation():
	# TODO: Set the animation based on the facing direction
	if xDirection == 0 and yDirection == 0:
		_animation_player.play("idle_" + facing)
	else:
		_animation_player.play("walk_" + facing)
	# Use: _animation_player.play("idle_" + facing)
	# This combines "idle_" with whatever direction we're facing
	pass
var coins=0
func change_coins(amount):
	coins+=amount
# TODO: Create health change function for interactions
func change_health(amount):
	# TODO: Add amount to health (positive = heal, negative = damage)
	# TODO: Make sure health stays between 0 and maxHealth
	# TODO: Print the new health value
	# TODO: Check if health <= 0 for death (optional challenge)
	print("Health changed by: -1", amount)


	

	# TODO: Create a new projectile instance
	# Look at the documentation examples in the lesson
	
	
	# TODO: Set projectile position to player position
	# Look at the "Setting Object Position" example
	
	
	# TODO: Set projectile direction using facing variable
	# Look at the "Calling Functions on Other Objects" example
	
	
	# TODO: Add projectile to the game world
	# Look at the "Adding Objects to the Game World" example
	
	
	# TODO: Print shooting confirmation
	# print("Shot projectile facing: ", facing)
	
	pass
	
func shoot():
	var new_projectile = projectile_original.instantiate()
	get_parent().add_child(new_projectile)
	new_projectile.set_direction(facing)
	var projectile_original = preload("res://scenes/projectile.tscn")
	new_projectile.global_position = position + Vector2(0,-25)

	pass
