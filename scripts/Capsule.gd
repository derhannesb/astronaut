extends RigidBody2D

var leaks

const leak_force = 60

func _ready():
	setup_refs()
	set_fixed_process(true)

func setup_refs():
	leaks = get_node("Leaks")

func _fixed_process(delta):
	for leak in leaks.get_children():
		var force_dir = Utils.radians_to_vec(leak.get_global_transform().get_rotation())
		var oxygen_factor = ((GameState.oxygen - 50) / 100) + 0.5
		var force_value = delta * leak_force * oxygen_factor
		add_force(leak.get_global_transform().get_origin(), force_dir * force_value)
