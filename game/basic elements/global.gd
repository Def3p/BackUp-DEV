extends Node

@onready var pl_pos = null

func add_pos(pos):
	pl_pos = pos
	
func ret_pos():
	return pl_pos
