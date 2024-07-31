extends CharacterBody2D

## Player character controller	

## Value used to slow down the player's velocity
@export var friction: float = 2.0

## Min value, which when velocity his lower than, stops the player
@export_range(0.1, 0.9, 0.1) var min_velocity_before_stop: float = 10.0

## A ratio by which the swipping power is multiplied by to improve the player's speed
@export var swiping_power_factor: float = 2.0

## Energy projectile object
var projectile: Resource = load("res://entities/projectiles/Projectile.tscn")

## Power charge buffer used to load energy
var power_charge: float = 0.0

## Boolean check for the energy charge and release
var is_charging: bool = false


## Apply a friction ration to the player's velocity [br]
##
## [color=yellow]Warning:[/color] This function will have to be improved.[br]
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


func _on_swipe_detector_energy_throw(power: Vector2):
	print_debug(
		"FACIAL with power : ", 
		Vector2(
			power_charge, power_charge
		) + velocity
	)
	stop_charging()
	shoot_projectile(power)


func _on_swipe_detector_start_energy_charge():
	is_charging = true


func _on_swipe_detector_reset():
	stop_charging()


func stop_charging():
	is_charging = false
	power_charge = 0.0
	

func shoot_projectile(projectile_initial_velocity: Vector2):
	var new_projectile = projectile.instantiate()
	new_projectile.velocity = projectile_initial_velocity
	new_projectile.spawn_position = global_position
	self.add_child.call_deferred(new_projectile)
