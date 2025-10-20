extends Area2D
@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D

var on = false
var in_range = false
var Player

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_filedialog_show_hidden") and in_range:
		if on == true:
			on = false
			animation_player.play("off")
		elif on == false:
			on = true
			animation_player.play("on")
			print ("lever3")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_range = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_range = false
