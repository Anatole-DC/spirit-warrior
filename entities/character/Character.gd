extends CharacterBody2D

@export var speed = 400
var target = global_position

func _physics_process(delta):
	if Input.is_mouse_button_pressed(1): # when click Left mouse button
		target = get_global_mouse_position()

	velocity = global_position.direction_to(target) * speed

	if global_position.distance_to(target) > 5:
		move_and_slide()
