extends RigidBody2D

var leaks

const leak_force = 120
var sfx_player = null

var org_linear_damp
var org_angular_damp

func _ready():
	setup_refs()
	set_fixed_process(true)
	org_angular_damp = get_angular_damp()
	org_linear_damp = get_linear_damp()

func setup_refs():
	leaks = get_node("Leaks")
	sfx_player = get_node("/root/Main/SfxPlayer")

func _fixed_process(delta):
	if (GameState.isGameOver):
		return

	if (abs(get_linear_velocity().x) > 400 || abs(get_linear_velocity().y) > 400):
		org_linear_damp = get_linear_damp()
		set_linear_damp(2)
	else:
		set_linear_damp(org_linear_damp)

	if (abs(get_angular_velocity()) > 2):
		org_angular_damp = get_angular_damp()
		set_angular_damp(20)
	else:
		set_angular_damp(org_angular_damp)

	for leak in leaks.get_children():
		var force_dir = Utils.radians_to_vec(leak.get_global_rot())

		var oxygen_factor = ((GameState.oxygen / 100) + 2) / 3
		var force_value = delta * leak_force * oxygen_factor
		add_force(leak.get_global_pos(), force_dir * force_value)

func _integrate_forces(state):
	for i in range (state.get_contact_count()):
		var contact_object = state.get_contact_collider_object(i)
		if ("Asteroids" in contact_object.get_groups()):
			if (!sfx_player.is_playing()):
				sfx_player.play()
