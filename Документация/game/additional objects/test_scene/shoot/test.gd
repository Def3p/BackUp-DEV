extends CharacterBody2D

@onready var piz = $Node2D

const BulletPath = preload('res://game/additional objects/bullet/bullet.tscn')

func _process(delta):
	
	if Input.is_action_just_pressed("shoot"):
		$Node2D.look_at(get_global_mouse_position())
		shoot()
		
		

func shoot():
	var bullet = BulletPath.instantiate()
	
	get_parent().add_child(bullet)
	bullet.position = $Node2D/Marker2D.global_position
	bullet.rotation = piz.rotation
	bullet.velocity = get_global_mouse_position() - bullet.position
	
