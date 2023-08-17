extends Node

@onready var pl_pos = null
@onready var pl_hp = 100

func add_pos(pos):
	pl_pos = pos
	
func ret_pos():
	return pl_pos

func damage(delta):
	pl_hp -= delta
	
func regen(delta):
	if pl_hp <= 100:
		pl_hp += delta
		if pl_hp > 100:
			pl_hp = 100

func hp_input():
	return pl_hp
