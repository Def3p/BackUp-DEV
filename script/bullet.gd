extends Area2D

var direction = Vector2(1, 0)
var speed = 800

func _process(delta):
	translate(direction.normalized() * speed * delta)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
