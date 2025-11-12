extends CharacterBody2D
var speed = 200
var maxHealth = 3
var health = maxHealth
var start_time = 0.67
var timer = start_time
var direction
var start_shoot_timer = 1.5
var shoot_timer = start_shoot_timer
var maxmelee = 1
var meleetimer = maxmelee
@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D

var chase_range = false
var melee_range = false
var shoot_range = false

var projectile_original = preload("res://scenes/enemy_arrow.tscn")


@onready var player: CharacterBody2D = %Player
var facing = "down"

func _ready():
	pass

func _process(_delta: float):
	
	if abs(position.x - player.position.x) > abs(position.y - player.position.y):
		if position.x > player.position.x:
			facing = "left"
		else:
			facing = "right"
	else:
		if position.y > player.position.y:
			facing = "up"
		else:
			facing = "down"

	timer -= _delta
	meleetimer -= _delta

	if shoot_range:
		shoot_timer -= _delta
		if shoot_timer < 0:
			shoot()
			shoot_timer = start_shoot_timer
		animation_player.play("crossbow_shoot_" + facing)


	elif chase_range and !melee_range:
		animation_player.play("walk_" + facing)
		direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		
		
		
	elif chase_range and melee_range:
		if player.is_in_group("player"):
			if meleetimer < 0:
				animation_player.play("attack_" + facing)
				player.change_health(-1)
				meleetimer = maxmelee
				
				
		
		
		
	elif !shoot_range and !chase_range and !melee_range:
		animation_player.play("idle_" + facing)
	
		
		
		
	
func change_health(_amount:int):
		if timer < 0:
			health += _amount
			print("minotaur health: ", health)
			timer = start_time
		if health < 1:
			die()
		if health > maxHealth:
			health = maxHealth

func die():
	queue_free()
	print("minotaur died")


func _on_melee_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		melee_range = true


func _on_melee_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		melee_range = false


func _on_chase_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase_range = true
		shoot_range = false


func _on_chase_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase_range = false
		shoot_range = true


func _on_ranged_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		shoot_range = true


func _on_ranged_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		shoot_range = false



func shoot():
	var projectile_clone = projectile_original.instantiate()
	projectile_clone.global_position = position
	projectile_clone.set_direction(player.position)
	get_tree().get_root().add_child(projectile_clone)
	pass
