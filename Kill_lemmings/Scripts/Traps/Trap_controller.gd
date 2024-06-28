extends Area2D
@onready var parent =$".."
var bodies = []


func _on_body_entered(body):
	bodies.append(body)
	if body.is_in_group("Enemy"):
		print("entro")
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
	pass
func Spike_Action(body):
	#Pendiente Señal
	while body in bodies:
		print(body.hp)
		body.hp-=parent.Damage
		print(body.hp)
		await wait(1)
		

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout


func _on_body_exited(body):
	bodies.erase(body)
