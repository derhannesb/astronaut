extends RigidBody2D

const max_distance_to_capsule = 4000

func _ready():
	get_node("Sprite").set_frame(rand_range(0, get_node("Sprite").get_hframes()-1))
	apply_impulse(Vector2(0,0), (get_node("/root/Main/Capsule").get_global_pos() + Vector2(rand_range(-500, 500), rand_range(-500,500)) - get_global_pos()).normalized() * rand_range(400, 1200))
	set_process(true)
	
	
func _process(delta):
	if (get_node("/root/Main/Capsule").get_pos().distance_to(get_pos()) > max_distance_to_capsule):
		queue_free()
