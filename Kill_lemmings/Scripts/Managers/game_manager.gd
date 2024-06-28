extends Node

const _goblin_path = "res://Scenes/Characters/Enemies/goblin.tscn"
var _enemy_references = {}
var _enemies_in_scene = []
var _current_step = 0
var _current_wave = 1
var _coins=10
@onready var label = $Label


const waves = {
	"wave_1": {
		"total_duration": 20, #Seconds
		"time_between": 5, #Seconds
		"spawns": 'Goblin'
	},
	"wave_2": {
		"total_duration": 20, #Seconds
		"time_between": 2, #Seconds
		"spawns": 'Goblin'
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	load_enemies()
	$Spawn_mob.wait_time = get_wave().time_between
	label.text= "Coins: " +str(_coins)
	#connect('mob_died', _on_mob_died)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	
	
func _on_mob_died(_name):
	#_enemies_in_scene = _enemies_in_scene.filter(func(mob): return mob.name != _name)
	pass
	
func get_wave():
	var wave_str = "wave_%s" % _current_wave
	if waves.has(wave_str):
		return waves[wave_str]
	else:
		return null	
	
func load_enemies():
	var enemy = preload(_goblin_path)
	_enemy_references['Goblin'] = enemy
	
func spawn_mobs():
	var wave = get_wave()
	if wave == null:
		return
		
	var current_enemy = wave.spawns
	var mob = _enemy_references[current_enemy].instantiate()
	mob.target_position = $Exit_point.global_position
	mob.global_position = $Start_point.global_position
	print("Mob position: %s" % mob.global_position)
	mob.global_scale = Vector2(0.6, 0.6)
	$Enemies.add_child(mob)
	_enemies_in_scene.append(mob)

func _on_spawn_mob_timeout():
	var wave = get_wave()
	if wave == null:
		$Spawn_mob.stop()
		return
		
	spawn_mobs()
	_current_step += wave.time_between
	
	if _current_step >= wave.total_duration:
		_current_step = 0
		_current_wave += 1
		
		var next_wave = get_wave()
		if next_wave == null:
			print("Finished")
			return 
			
		$Spawn_mob.wait_time = next_wave.time_between
		print("Next wave")
		
func add_coins(value):
	
	_coins+=value
	label.text= "Coins: " +str(_coins)
