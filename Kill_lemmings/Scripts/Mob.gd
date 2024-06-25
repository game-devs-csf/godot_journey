class_name Mob extends CharacterBody2D

var mob_name = "Mob"
var hp := 10
var att := 1
var def := 5
var speed : float = 300
var dead := false

@export var target : Vector2

var _animations : Array[String] = ['Idle', 'Attack', 'Run']

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	_animated_sprite.play('Idle')
	
func take_damage(value):
	hp -= value
	if hp <= 0:
		hp = 0
		dead = true
	
