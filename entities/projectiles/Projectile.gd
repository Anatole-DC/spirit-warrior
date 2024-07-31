extends CharacterBody2D

var spawn_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Spawing new projectile")
	global_position = spawn_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move_and_slide()


func _on_projectile_lifetime_timer_timeout():
	queue_free()
	print("Projectile destroyed")
