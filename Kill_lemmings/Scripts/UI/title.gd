extends Node2D

@onready var skeleton = $skeleton
@onready var animation_player = $CanvasLayer/Node2D/AnimationPlayer

func _ready():
	animation_player.play("Title_Animation")

func _on_button_pressed():
	skeleton.play("play")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/Play_scenes/horizontal_playground.tscn")
