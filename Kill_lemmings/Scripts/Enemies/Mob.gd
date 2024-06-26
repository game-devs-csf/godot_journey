class_name Mob 
extends CharacterBody2D
## Base class for the enemies

enum state {Idle, Running, Attacking, Death}
enum directions {Left, Right}

@export var mob_name = "Mob"
@export var target_position : Vector2 = Vector2(0,0)
@export var max_hp := 10

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var _animated_sprite = $AnimatedSprite2D

var mobs_entered = 0
@onready var Manager= $"..".get_parent()

signal mob_died
signal mob_arrived
signal mob_damaged

var hp : int = max_hp:
	set(value): 
		hp = clamp(value, 0, max_hp)			
	
var _current_state : state = state.Idle:
	set(value):
		_current_state = value
		set_animation()

var _current_direction : directions = directions.Right:
	set(value):
		_current_direction = value
		if value == directions.Left:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var att : int = 2
var def : int = 5
var movement_speed : float = 5000
var dead : bool = false
var on_target : bool = false
var type = ""
var _animations : Array[String] = ['Idle', 'Run', 'Attack', 'Death']
		
func _ready():
	_current_state = state.Running
	set_animation()
	call_deferred("actor_setup")
	mob_died.connect(_on_mob_died)
	mob_arrived.connect(Manager._on_mob_arrived)
	mob_arrived.connect(_on_mob_arrived)
	
func _process(_delta):
	if on_target:
		if _current_state != state.Idle: _current_state = state.Idle
		emit_signal('mob_arrived', name)
		return
			
func _physics_process(delta):
	if _current_state in [state.Attacking, state.Idle, state.Death]:
		velocity.x = 0
		return 
		
	if navigation_agent.is_navigation_finished():
		on_target = true
		return
	
	if not is_on_floor():
		velocity.y += gravity * delta

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	change_direction(next_path_position)
	
	velocity.x = current_agent_position.direction_to(next_path_position).x * movement_speed * delta
	move_and_slide()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(target_position)
	
func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
	
func set_animation():
	#if _animated_sprite.is_playing():
		#await _animated_sprite.animation_looped
	_animated_sprite.play(_animations[_current_state])
	
func change_direction(_target: Vector2):
	var direction = global_position.direction_to(_target)

	if direction.x < 0:
		_current_direction = directions.Left
		
	if direction.x > 0:
		_current_direction = directions.Right
			
func take_damage(value : int) -> void:
	hp -= value
	mob_damaged.emit(hp)
	if hp <= 0:
		dead = true
		Manager.add_coins(5,type)
		mob_died.emit(name)

func _on_mob_died(_name):
	_current_state = state.Death
	velocity = Vector2(0,0)
	Manager._enemies_in_scene.erase(self)

func _on_mob_arrived(_name):
	await wait(0.75)	
	queue_free()
	Manager._mobs_entered+=1
	print(str(Manager._mobs_entered))
