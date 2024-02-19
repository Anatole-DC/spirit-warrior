extends CharacterBody2D

@export var friction: float = 2.0
@export_range(0.1, 0.9, 0.1) var min_velocity_before_stop: float = 10.0

func apply_friction_to_velocity(current_inertia: Vector2):
	if velocity.distance_to(Vector2.ZERO) < min_velocity_before_stop:
		return Vector2.ZERO
	return current_inertia * 1/(1 + friction / 1000)

func _physics_process(_delta):
	velocity = apply_friction_to_velocity(velocity)
	move_and_slide()

func _on_swipe_detector_swipe(power: Vector2):
	velocity = velocity + power
