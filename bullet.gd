extends CharacterBody2D

var speed = 800

#func _process(delta):
#	translate(direction.normalized() * speed * delta)
func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
