extends RigidBody2D

var leaks

func _ready():
	setup_refs()
	set_fixed_process(true)

func setup_refs():
	leaks = get_node("Leaks")

func _fixed_process(delta):
	for leak in leaks.get_children():
		var rot = leak.get_global_transform().get_rotation()
		var dist = Vector2(sin(rot), cos(rot)).normalized()
		add_force(leak.get_global_transform().get_origin(), dist * 1.5)
