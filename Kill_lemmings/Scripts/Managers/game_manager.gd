extends Node
const _skeleton_path = "res://Scenes/Characters/Enemies/skeleton.tscn"
const _goblin_path = "res://Scenes/Characters/Enemies/goblin.tscn"
const _ogre_path = "res://Scenes/Characters/Enemies/ogre.tscn"

var _enemy_references = {}
var _enemies_in_scene = []
var _current_step = 0
var _current_wave = 1
var _ogres_counter=0
var _skeleton_counter=0
var _coins=50
var _mobs_entered = 0
var _waves_finished=false


@onready var label = $Label

const waves = {
	"wave_1": {
		"total_duration": 20, #Seconds
		"time_between": 5, #Seconds
		"spawns": ['Ogre']
	},
	"wave_2": {
		"total_duration": 30, #Seconds
		"time_between": 4, #Seconds
		"spawns": ['Skeleton']
	},
	"wave_3": {
		"total_duration": 40, #Seconds
		"time_between": 3, #Seconds
		"spawns": ['Ogre', 'Skeleton']
	},
	"wave_4": {
		"total_duration": 50, #Seconds
		"time_between": 2, #Seconds
		"spawns": ['Ogre', 'Skeleton']
	},
	"wave_5": {
		"total_duration": 100, #Seconds
		"time_between": 2, #Seconds
		"spawns": ['Ogre', 'Skeleton']
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
	if _waves_finished and _enemies_in_scene.is_empty():
		#AQUI VA LA ESCENA DE GANAR
		print("ganaste")
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://Scenes/UI/win_scene.tscn")
	pass
	
func _on_mob_arrived(_name):
	$Doors/ExitDoor.animated_door.play('open_close')
	if(_mobs_entered==10):
		print("Perdiste")
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://Scenes/UI/loss_scene.tscn")
		#AQUI VA LA ESCENA DE PERDER
	
	
func get_wave():
	var wave_str = "wave_%s" % _current_wave
	if waves.has(wave_str):
		$Waves_label.text="Waves: "+str(_current_wave)
		return waves[wave_str]
	else:
		return null	
	
func load_enemies():
	_enemy_references['Goblin'] = preload(_goblin_path)
	_enemy_references['Skeleton'] = preload(_skeleton_path)
	_enemy_references['Ogre'] = preload(_ogre_path)
	
func spawn_mobs():
	var wave = get_wave()
	if wave == null:
		return
	
	$Doors/EntryDoor.animated_door.play('open_close')
	await wait(0.5)
	var _current_enemy = wave.spawns[randi() % wave.spawns.size()]
	var mob = _enemy_references[_current_enemy].instantiate()
	mob.type = _current_enemy
	mob.target_position = $Doors/Exit_point.global_position
	mob.global_position = $Doors/Start_point.global_position
	mob.global_scale = Vector2(0.6, 0.6)
	$Enemies.add_child(mob)
	_enemies_in_scene.append(mob)

func _on_spawn_mob_timeout():
	var wave = get_wave()
	if wave == null:
		_waves_finished=true
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
		
func add_coins(value, mob_type):
	
	_coins+=value
	label.text= "Coins: " +str(_coins)
	match (mob_type):
		"Ogre":
			_ogres_counter+=1
			$Goblin_counter/Label.text=str(_ogres_counter)
		"Skeleton":
			_skeleton_counter+=1
			$Skeleton_counter/Label.text=str(_skeleton_counter)
		"trap":
			pass

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/title.tscn")
