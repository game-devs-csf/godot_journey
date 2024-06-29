extends Node2D

@onready var animation_player = $CanvasLayer/Node2D/AnimationPlayer

@onready var skeleton = $skeleton

func _ready():
	animation_player.play("Start")
	
func _on_button_pressed():
	skeleton.play("play")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/Play_scenes/horizontal_playground.tscn")
