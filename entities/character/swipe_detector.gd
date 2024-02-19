extends Node

signal hold_press
signal swipe(power: Vector2)

@export var min_swipe_length: int = 50
@export var swiping_power_factor: float = 2.0

var start_position: Vector2
var end_position: Vector2
var is_swiping = true


func process_click(position: Vector2):
	start_position = position

func process_release(position: Vector2):
	end_position = position
	if is_swiping:
		swipe.emit(process_swiping_power())
		return

func process_swiping_power():
	return Vector2(
		end_position.x - start_position.x,
		end_position.y - start_position.y
	) * swiping_power_factor


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			process_click(event.position)
		else:
			process_release(event.position)
	elif event is InputEventMouseMotion:
		is_swiping = true
