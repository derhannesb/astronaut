extends Node2D

var crane_target = null
var crane_ready = false

func _ready():
	crane_target = get_node("/root/Main/Capsule")
	set_process(true)

func _process(delta):
	var dir = crane_target.get_global_pos() - get_global_pos()
	var dist = dir.length()
	var animation_player = get_node("AnimationPlayer")

	var target_rot = Utils.vec_to_radians(dir) - PI

	if (dist > 1000 && animation_player.get_current_animation() != "idle"):
		animation_player.play("idle")

	if (crane_ready):
		set_global_rot(target_rot)

		if (dist < 600 && animation_player.get_current_animation() != "grab"):
			animation_player.play("grab")
	elif(!crane_ready && dist > 1000):
		crane_ready = true
