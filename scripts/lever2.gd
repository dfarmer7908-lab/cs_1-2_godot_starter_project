extends Area2D
@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = %Player
var on = false
var in_range = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_filedialog_show_hidden") and in_range:
		if on == true:
			on = false
			player.lever2 = false
			animation_player.play("off")
		elif on == false:
			on = true
			player.lever2 = true
			animation_player.play("on")
		
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_range = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_range = false
