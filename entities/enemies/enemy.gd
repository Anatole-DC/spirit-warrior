extends CharacterBody2D


func _on_player_collision(body):
	body.die()
