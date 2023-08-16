extends CharacterBody2D

var dir = Vector2(1, 0)
var speed = 500

func _physics_process(delta):
	var collision_info = move_and_collide(dir.normalized() * delta * speed)
