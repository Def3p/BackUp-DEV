extends Node2D

@onready var os = $rotair_tur
@onready var on_off = $"on _ off"
@onready var gun = $"rotair_tur/Turel-gun"

@onready var raycast = $rotair_tur/RayCast2D

const BulletPath = preload('res://game/additional objects/bullet/bullet.tscn')

func _process(delta):
	if global_transform.origin[0] > get_global_mouse_position()[0]:
		$rotair_tur/Marker2D.position[1] = -5
		$"rotair_tur/Turel-gun".position[1] = -5
		$rotair_tur/turret_hitbox.position[1] = -10
		$rotair_tur/RayCast2D.position[1] = -5
		
		on_off.flip_h = true
		gun.flip_v = true
	if global_transform.origin[0] <= get_global_mouse_position()[0]:
		$rotair_tur/Marker2D.position[1] = 5
		$"rotair_tur/Turel-gun".position[1] = 5
		$rotair_tur/turret_hitbox.position[1] = 0
		$rotair_tur/RayCast2D.position[1] = 5
		on_off.flip_h = false
		gun.flip_v = false
	$rotair_tur.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
		

func shoot():
	var bullet = BulletPath.instantiate()
	
	get_parent().add_child(bullet)
	bullet.position = $rotair_tur/Marker2D.global_position
	bullet.rotation = os.rotation
	bullet.dir = get_global_mouse_position() - bullet.position
