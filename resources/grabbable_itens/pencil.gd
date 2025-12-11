extends Sprite2D

var mouse_in: bool

func _process(delta):
	if !mouse_in:
		return

	if int(Input.is_action_just_pressed("mouse_right_click")):
		$WriteButtom.visible = !$WriteButtom.visible

func _on_area_2d_mouse_entered():
	mouse_in = true


func _on_area_2d_mouse_exited():
	mouse_in = false


func _on_write_buttom_button_down():
	pass # Replace with function body.
