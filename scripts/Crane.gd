extends Node2D

var crane_target = null


func _ready():
	crane_target = get_node("/root/Main/Capsule")
	set_process(true)
	
func _process(delta):
	var dir = crane_target.get_global_pos() - get_global_pos()
	set_global_rot(Utils.vec_to_radians(dir) + PI)
	if (dir.length() < 600 && get_node("AnimationPlayer").get_current_animation() != "grab"):
		get_node("AnimationPlayer").play("grab")
	if (dir.length() > 1000 && get_node("AnimationPlayer").get_current_animation() != "idle"):
		get_node("AnimationPlayer").play("idle")