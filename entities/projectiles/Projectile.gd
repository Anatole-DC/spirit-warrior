extends Area2D

var spawn_position: Vector2
var direction: float = 0.0
var speed: float = 0.0

@export var lifetime: float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = spawn_position
	$ProjectileLifetimeTimer.start(lifetime)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += Vector2.RIGHT.rotated(direction) * speed * delta

func _on_projectile_lifetime_timer_timeout():
	queue_free()

func _on_body_entered(body: Node2D):
	body.queue_free()
