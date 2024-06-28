class_name Spikes
extends Trap

var bodies = []

func _on_timer_timeout():
	for body in bodies:
		body.take_damage(Damage)
		
		if(body.type == "Skeleton"):
			Damage -= 1
			#
		print(Damage)

func _on_area_spikes_body_entered(body):
	if body.is_in_group("Enemy"):
		bodies.append(body)
		_on_timer_timeout()

func _on_area_spikes_body_exited(body):
	bodies.erase(body)
