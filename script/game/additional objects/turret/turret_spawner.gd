extends Node2D

@onready var anim_spawn = $on_off
var posit_pl = null

var on = false
var shot_tur = false

const turretSP = preload('res://game/additional objects/turret/turret.tscn')

func _process(delta):
	posit_pl = Global.ret_pos()
	if global_transform.origin[0] > posit_pl[0]:
		anim_spawn.flip_h = false
	if global_transform.origin[0] <= posit_pl[0]:
		anim_spawn.flip_h = true
		
	if on:
		if !shot_tur and anim_spawn.frame != 16:
			anim_spawn.play("on")
		if anim_spawn.frame == 16:
			anim_spawn.stop()
			anim_spawn.visible = false
			shot_tur = true
			on = false
			add_tur()
	

func _on_area_2d_body_entered(body):
	if body is Player:
			on = true
	
func add_tur():
	var turret = turretSP.instantiate()
	get_parent().add_child(turret)
	turret.position = $".".global_position



