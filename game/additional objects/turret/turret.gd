extends Node2D

@onready var os = $rotair_tur
@onready var on_off = $"on _ off"

@onready var gun = $"rotair_tur/Turel-gun"
@onready var RelTime = $rotair_tur/RayCast2D/ReloadTimer
@onready var raycast = $rotair_tur/RayCast2D
var posit_pl = null

const BulletPath = preload('res://game/additional objects/bullet/bullet.tscn')

func _process(delta):
	posit_pl = Global.ret_pos()
	if global_transform.origin[0] > posit_pl[0]:
		$rotair_tur/Marker2D.position[1] = -5
		$"rotair_tur/Turel-gun".position[1] = -5
		$rotair_tur/turret_hitbox.position[1] = -10
		$rotair_tur/RayCast2D.position[1] = -5
		on_off.flip_h = true
		gun.flip_v = true
	if global_transform.origin[0] <= posit_pl[0]:
		$rotair_tur/Marker2D.position[1] = 5
		$"rotair_tur/Turel-gun".position[1] = 5
		$rotair_tur/turret_hitbox.position[1] = 0
		$rotair_tur/RayCast2D.position[1] = 5
		on_off.flip_h = false
		gun.flip_v = false
	$rotair_tur.look_at(posit_pl)
	if raycast.get_collider() is Player:
		shoot()

func shoot():
	var bullet = BulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $rotair_tur/Marker2D.global_position
	bullet.rotation = os.rotation
	bullet.dir = posit_pl - bullet.position
	
func _on_reload_timer_timeout():
	raycast.enabled = true

