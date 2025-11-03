extends CharacterBody2D
var speed = 150
var maxHealth = 5
var health = maxHealth
var start_time = .67
var timer = start_time
var direction
var start_shoot_timer = 1.5
var shoot_timer = start_shoot_timer

@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D

var chasing = false
var meleeing = false
var in_range = false

var projectile_original = preload("res://scenes/enemy_projectile.tscn")
#replace the thing above with the thing below
#var arrow_projectile = preload("res://scenes/arrow.tscn")

@onready var player: CharacterBody2D = %Player
var facing = "down"

func _ready():
	pass

func _process(_delta: float):
	
	timer -= _delta
	
	if in_range:
		shoot_timer -= _delta
		if shoot_timer < 0:
			shoot(player)
			shoot_timer = start_shoot_timer
		animation_player.play("crossbow_shoot_" + facing)
		
		pass
		
	elif chasing and !meleeing:
		animation_player.play("walk_" + facing)
		#position += direction * speed * _delta
		
		pass
		
	elif chasing and meleeing:
		animation_player.play("attack_" + facing)
		
		pass
		
	elif !in_range and !chasing and !meleeing:
		animation_player.play("idle_" + facing)
		
		pass
	
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
		meleeing = true


func _on_melee_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		meleeing = false


func _on_chase_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chasing = true
		in_range = false


func _on_chase_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chasing = false
		in_range = true


func _on_ranged_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_range = true


func _on_ranged_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_range = false



func shoot(player):
	var projectile_clone = projectile_original.instantiate()
	projectile_clone.global_position = position
	projectile_clone.set_direction(player.position)
	get_tree().get_root().add_child(projectile_clone)
	#var arrow_clone = arrow_projectile.instantiate()
	#arrow_clone.global_position = position
	#arrow_clone.set_direction(player.position)
	#get_tree().get_root().add_child(arrow_clone)
	pass
