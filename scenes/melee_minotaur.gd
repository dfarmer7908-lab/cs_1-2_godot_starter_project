extends CharacterBody2D
var speed = 200
var maxHealth = 5
var health = maxHealth
var start_time = .67
var timer = start_time
var direction
var start_shoot_timer = 1.5
var shoot_timer = start_shoot_timer
var maxmelee = 0.67
var meleetimer = maxmelee
@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D

var chasing = false
var meleeing = false
var in_range = false

var projectile_original = preload("res://scenes/enemy_arrow.tscn")


@onready var player: CharacterBody2D = %Player
var facing = "down"

func _ready():
	pass

func _process(_delta: float):
	

	timer -= _delta
	meleetimer -= _delta
	
	if in_range:
		shoot_timer -= _delta
		if shoot_timer < 0:
			shoot()
			shoot_timer = start_shoot_timer
		animation_player.play("crossbow_shoot_" + facing)


	elif chasing and !meleeing:
		animation_player.play("walk_" + facing)
		direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		#chase
		pass
		
	elif chasing and meleeing:
		animation_player.play("attack_" + facing)
		if player.is_in_group("player"):
			if meleetimer < 0:
				player.change_health(-3)
				meleetimer = maxmelee
		#chase and melee
		pass
		
	elif !in_range and !chasing and !meleeing:
		animation_player.play("idle_" + facing)
	if player.position.x < position.x - 10:
		facing = "left"
		
	elif player.position.x > position.x + 10:
		facing = "right"
		
	elif player.position.y > position.y:
		facing = "down"
		
	elif player.position.y < position.y:
		facing = "up"
		
		#stop everything/look at player
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



func shoot():
	var projectile_clone = projectile_original.instantiate()
	projectile_clone.global_position = position
	projectile_clone.set_direction(player.position)
	get_tree().get_root().add_child(projectile_clone)
	pass
