extends Node2D

func _ready():
	set_process(true)

func _process(delta):
	var station = get_node("/root/Main/SpaceStation/Sprite")
	var dir = station.get_global_pos() - get_global_pos()
	set_global_rot(Utils.vec_to_radians(dir) + PI)
	
	if (dir.length() < 400):
		GameState.winGame()
