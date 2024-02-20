extends Node

signal start_energy_charge
signal energy_shield
signal energy_throw
signal swipe(power: Vector2)
signal reset

@export var min_swipe_length: int = 50
@export var min_delay_before_charge: float = 0.3

var start_position: Vector2
var end_position: Vector2

var is_charging = false
var is_swiping = false

func reset_values():
	is_charging = false
	is_swiping = false
	$Timer.stop()

func process_click(position: Vector2):
	reset_values()
	$Timer.start(min_delay_before_charge)
	start_position = position

func process_release(position: Vector2):
	end_position = position

	if is_swiping and !is_charging:
		swipe.emit(process_swiping_power())
	elif is_charging and !is_swiping:
		energy_shield.emit()
	elif is_charging and is_swiping:
		energy_throw.emit()

	reset_values()

func process_swiping_power():
	return Vector2(
		end_position.x - start_position.x,
		end_position.y - start_position.y
	)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			process_click(event.position)
		else:
			process_release(event.position)
	elif event is InputEventMouseMotion:
		is_swiping = true


func _on_timer_timeout():
	print_debug("Timeout")
	if !is_swiping:
		is_charging = true
		start_energy_charge.emit()
