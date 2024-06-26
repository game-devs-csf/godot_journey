extends Node2D

enum State  {Selected, Unselected}
var Actual_state=State.Unselected

func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		Actual_state=State.Selected

func _physics_process(delta):
	if Actual_state==State.Selected:
		global_position= lerp(global_position, get_global_mouse_position(), 25 *delta)
		
		
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			Actual_state=State.Unselected
