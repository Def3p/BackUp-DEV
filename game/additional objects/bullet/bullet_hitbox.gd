extends Area2D

func _on_body_entered(body):
	if body is Player or body is wall_floor_bg:
		get_parent().queue_free()
