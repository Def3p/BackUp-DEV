extends CharacterBody2D

const BulletPath = preload("res://scene/bullet.tscn")

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var bullet = BulletPath.instantiate()
	
	get_parent().add_child(bullet)
	bullet.position = $rotair_tur/Marker2D.global_position
	
func _physics_process(delta):
	pass
		

