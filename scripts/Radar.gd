extends Node2D

var crane

func _ready():
	crane = get_node("/root/Main/SpaceStation/Crane")
	set_process(true)

func _process(delta):
	var station = get_node("/root/Main/SpaceStation")
	var dir = station.get_global_pos() - get_global_pos()
	set_global_rot(Utils.vec_to_radians(dir) + PI)
