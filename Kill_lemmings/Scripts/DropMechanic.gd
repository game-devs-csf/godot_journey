extends Node2D

@onready var Parent = $".." 



var draggable=false
var is_inside_dropable=false 
var position_ref
var offset :Vector2
var initial_pos :Vector2
var actual_body : StaticBody2D
var counter_area=0

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initial_pos=global_position
			offset=get_global_mouse_position() - global_position
			Global.dragging=true
			
		if Input.is_action_pressed("click"):
			global_position=get_global_mouse_position() - offset
			
		elif Input.is_action_just_released("click"):
			Global.dragging=false
			var tween = get_tree().create_tween()
			if is_inside_dropable or counter_area!= 0:
				tween.tween_property(self,"position", position_ref, 0.2).set_ease(Tween.EASE_OUT)
				counter_area = 0
			else:
				tween.tween_property(self,"position", initial_pos, 0.2).set_ease(Tween.EASE_OUT)
			
		


func _on_area_2d_body_entered(body):
	if body.is_in_group('Dropable'):
		is_inside_dropable=true
		counter_area=1
		body.modulate=Color(Color.BLACK,1)
		position_ref=body.position
		
func _on_area_2d_body_exited(body):
	if body.is_in_group('Dropable') :
		is_inside_dropable=false
		body.modulate=Color(Color.GRAY,0.7)
		

func _on_area_2d_mouse_entered():
	if not Global.dragging:
		draggable=true
		scale=Vector2(1.05,1.05)


func _on_area_2d_mouse_exited():
	if not Global.dragging:
		draggable=false
		scale=Vector2(1.0,1.0)
