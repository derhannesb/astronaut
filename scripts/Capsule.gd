extends RigidBody2D

var leaks

const leakForce = 60

func _ready():
	setup_refs()
	set_fixed_process(true)

func setup_refs():
	leaks = get_node("Leaks")

func _fixed_process(delta):
	for leak in leaks.get_children():
		var dir = utils.radians_to_vec(leak.get_global_transform().get_rotation())
		add_force(leak.get_global_transform().get_origin(), dir * delta * leakForce)
