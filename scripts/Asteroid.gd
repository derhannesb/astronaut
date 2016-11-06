extends RigidBody2D

const max_distance_to_capsule = 4000

export var min_force = 100
export var max_force = 1000

var capsule

func _ready():
	capsule = get_node("/root/Main/Capsule")

	var sprite = get_node("Sprite")
	sprite.set_frame(rand_range(0, sprite.get_hframes() - 1))
	var rand_offset = Vector2(rand_range(-2500, 2500), rand_range(-2500, 2500))
	var dir = ( (capsule.get_global_pos() + rand_offset) - get_global_pos() ).normalized()
	var rand_forec = rand_range(min_force, max_force)
	apply_impulse(Vector2(0,0), dir * rand_forec)

	set_process(true)

func _process(delta):
	if (capsule.get_pos().distance_to(get_pos()) > max_distance_to_capsule):
		queue_free()
