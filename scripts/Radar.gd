extends Node2D

func _ready():
	set_process(true)

func _process(delta):
	#set_global_rot( get_global_pos().angle_to( get_node("/root/Main/SpaceStation").get_global_pos() ))


	set_global_rot ( Utils.vec_to_radians(get_node("/root/Main/SpaceStation").get_global_pos() - get_global_pos()) + PI)
