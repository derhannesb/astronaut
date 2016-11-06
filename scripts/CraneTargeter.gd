extends Position2D

var crane_target = null
var crane_max_length = 250

func _ready():
	crane_target = get_node("/root/Main/Capsule")
	set_process(true)
	
func _process(delta):
	var target_norm = (crane_target.get_global_pos() - get_global_pos()).normalized()
	var new_pos = target_norm*crane_max_length
	set_pos(new_pos)
	print("pos: " + str(new_pos))
	