extends Area2D
@onready var parent =$".."
var bodies = []
var body_counter=0
	
func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		bodies.append(body)
		#print("entro")
		match parent.Trap_type:
			0:
				print("entro 1")
				Box_Action(body)
			1:
				print("entro 2")
				Pit_Action(body)
			2:
				print("entro 3")
				Spike_Action(body)

func Box_Action(body):
	pass	
	
func Pit_Action(body):
	body.get_node("CollisionShape2D").queue_free()
	await wait(0.2)
	body.mob_died.emit(name)
	$"..".get_parent().add_coins(5)
	body_counter+=1
	if body_counter==5:
		$"..".trap_destroyed.emit()
	
func Spike_Action(body):
	#Pendiente Señal
	while body in bodies:
		body.take_damage(parent.Damage)
		
		if(body.type == "Skeleton"):
			print("Collided with skeleton: %s" % body.name)
			parent.Damage -= 1
			
		print(parent.Damage)
		await wait(1)		

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

func _on_body_exited(body):
	bodies.erase(body)
