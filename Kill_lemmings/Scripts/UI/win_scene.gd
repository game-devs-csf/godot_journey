extends Node2D
@onready var skeleton = $skeleton
@onready var knight = $knight

func _ready():
	skeleton.play("death")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Play_scenes/horizontal_playground.tscn")
