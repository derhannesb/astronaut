extends RigidBody2D

var leaks

const leak_force = 60
var sfx_player = null

func _ready():
	sfx_player = get_node("/root/Main/SfxPlayer")
	setup_refs()
	set_fixed_process(true)

func setup_refs():
	leaks = get_node("Leaks")

func _fixed_process(delta):
	if (GameState.isGameOver):
		return

	if (abs(get_linear_velocity().x) > 400 || abs(get_linear_velocity().y) > 400):
		set_linear_damp(2)
	else:
		set_linear_damp(0.4)

	if (abs(get_angular_velocity()) > 1.5):
		set_angular_damp(20)
	else:
		set_angular_damp(6)

	for leak in leaks.get_children():
		var force_dir = Utils.radians_to_vec(leak.get_global_transform().get_rotation())
		var oxygen_factor = ((GameState.oxygen - 50) / 100) + 0.5
		var force_value = delta * leak_force * oxygen_factor
		add_force(leak.get_global_transform().get_origin(), force_dir * force_value)

func _integrate_forces(state):
	for i in range (state.get_contact_count()):
		var contact_object = state.get_contact_collider_object(i)
		if ("Asteroids" in contact_object.get_groups()):
			if (!sfx_player.is_playing()):
				sfx_player.play()
