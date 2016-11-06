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

func _integrate_forces(state):
	print(state.get_contact_count())
	for i in range (state.get_contact_count()):
		var contact_object = state.get_contact_collider_object(i)
		if ("Asteroids" in contact_object.get_groups()):
			get_node("/root/Main/SfxPlayer").play()
