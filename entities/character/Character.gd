extends CharacterBody2D

## Player character controller	


## Value used to slow down the player's velocity
@export var velocity_curve: Curve
## Min value, which when velocity his lower than, stops the player
@export var max_speed: float = 2000.0
@export var time_to_stop: float = 5.0
@export var dash_speed: float = 700
## Time since the beggining of the slide
var time_slide_begin: float = 0.0
## Speed represents the magnitude of the velocity vector
var speed: float = 0.0
## Direction represents the velocity angle to the x axis
var character_direction: float = 0.0



## Energy projectile object
var projectile: Resource = load("res://entities/projectiles/Projectile.tscn")
@export var projectile_power: float = 600

## Power charge buffer used to load energy
var power_charge: float = 0.0
## Boolean check for the energy charge and release
var is_charging: bool = false


## Apply a friction ration to the player's velocity [br]
##
## [color=yellow]Warning:[/color] This function will have to be improved.[br]
func apply_friction_to_velocity() -> Vector2:
	if speed == 0.0:
		return Vector2.ZERO
	time_slide_begin = clamp(time_slide_begin + get_physics_process_delta_time(), 0, time_to_stop)
	speed = clamp(speed * velocity_curve.sample(time_slide_begin / time_to_stop), 0, max_speed)
	return Vector2.RIGHT.rotated(character_direction) * speed


func _physics_process(_delta):
	velocity = apply_friction_to_velocity()
	move_and_slide()

func _get_current_speed() -> float:
	return velocity.length()

func _process(delta):
	if is_charging:
		power_charge = power_charge + delta
		$Camera2D.apply_shake(power_charge)

func _on_swipe_detector_swipe(movement: Vector2):
	stop_charging()
	time_slide_begin = 0.0
	character_direction = movement.angle()
	speed = new_speed_from_new_direction_angle(character_direction)

func new_speed_from_new_direction_angle(new_direction_angle: float) -> float:
	if abs(new_direction_angle - velocity.angle()) > deg_to_rad(90):
		return dash_speed
	return speed + dash_speed

func _on_swipe_detector_energy_shield():
	stop_charging()
	transfer_energy()


func _on_swipe_detector_energy_throw(power: Vector2):
	var player_energy = transfer_energy()
	shoot_projectile(power.angle(), player_energy + (projectile_power * power_charge))
	stop_charging()


func _on_swipe_detector_start_energy_charge():
	is_charging = true


func _on_swipe_detector_reset():
	stop_charging()

func stop_charging():
	is_charging = false
	power_charge = 0.0

func transfer_energy() -> float:
	var energy_transfered: float = speed
	speed = 0
	return energy_transfered
	

func shoot_projectile(angle: float, power: float):
	var new_projectile = projectile.instantiate()
	new_projectile.velocity = Vector2.RIGHT.rotated(angle) * power
	new_projectile.spawn_position = position
	get_tree().get_root().add_child.call_deferred(new_projectile)
