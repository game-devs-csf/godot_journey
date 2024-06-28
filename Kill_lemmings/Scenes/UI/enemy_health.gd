extends Control
@onready var health_bar = $Background/HealthBar

var max_health = 10:
	set(value):
		max_health = value
		health_bar.max_value = max_health
		
var current_health = 10:
	set(value):
		current_health = clamp(value, 0, max_health)
		health_bar.value = current_health
