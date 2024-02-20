extends CharacterBody2D

@export var friction: float = 2.0
@export_range(0.1, 0.9, 0.1) var min_velocity_before_stop: float = 10.0
@export var swiping_power_factor: float = 2.0

var power_charge: float = 0.0
var is_charging: bool = false

func apply_friction_to_velocity(current_inertia: Vector2):
	if velocity.distance_to(Vector2.ZERO) < min_velocity_before_stop:
		return Vector2.ZERO
	return current_inertia * 1/(1 + friction / 1000)

func _physics_process(_delta):
	velocity = apply_friction_to_velocity(velocity)
	move_and_slide()

func _process(delta):
	if is_charging:
		power_charge = power_charge + delta
		$Camera2D.apply_shake(power_charge)

func _on_swipe_detector_swipe(power: Vector2):
	print_debug("WAZAAA")
	stop_charging()
	velocity = velocity + power


func _on_swipe_detector_energy_shield():
	print_debug("SHIELD with power : ", power_charge)
	stop_charging()


func _on_swipe_detector_energy_throw():
	print_debug("FACIAL with power : ", power_charge)
	stop_charging()


func _on_swipe_detector_start_energy_charge():
	is_charging = true


func _on_swipe_detector_reset():
	stop_charging()

func stop_charging():
	is_charging = false
	power_charge = 0.0
