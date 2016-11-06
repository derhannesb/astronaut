extends KinematicBody2D

export var speed = 2.5

const DIR_N  = 0
const DIR_NW = 1
const DIR_W  = 2
const DIR_SW = 3
const DIR_S  = 4
const DIR_SE = 5
const DIR_E  = 6
const DIR_NE = 7

const leak_dummy = preload("res://scns/Leak.tscn")

var animation_player
var capsule
var leaks

func _ready():
	setup_refs()
	set_fixed_process(true)

func setup_refs():
	animation_player = get_node("PlayerAnimationPlayer")
	capsule = get_node("../../Capsule")
	leaks = get_node("../Leaks")

func _fixed_process(delta):
	var btn_top_pressed = Input.is_action_pressed("PlayerMoveTop")
	var btn_right_pressed = Input.is_action_pressed("PlayerMoveRight")
	var btn_bottom_pressed = Input.is_action_pressed("PlayerMoveBottom")
	var btn_left_pressed = Input.is_action_pressed("PlayerMoveLeft")

	# Rotate
	var dir = null
	if (btn_top_pressed && btn_right_pressed):
		dir = DIR_NE
	elif (btn_right_pressed && btn_bottom_pressed):
		dir = DIR_SE
	elif (btn_bottom_pressed && btn_left_pressed):
		dir = DIR_SW
	elif (btn_left_pressed && btn_top_pressed):
		dir = DIR_NW
	elif (btn_top_pressed):
		dir = DIR_N
	elif (btn_right_pressed):
		dir = DIR_E
	elif (btn_bottom_pressed):
		dir = DIR_S
	elif (btn_left_pressed):
		dir = DIR_W

	# Move

	if dir != null:
		set_rotd((dir * 45) - capsule.get_rotd())

		get_node("FixedRot").set_global_rot(0)

		var canMove = true
		if (dir == DIR_N):
			canMove = !get_node("FixedRot/WalkRayN").is_colliding()
		elif (dir == DIR_NW):
			canMove = !get_node("FixedRot/WalkRayNW").is_colliding()
		elif (dir == DIR_W):
			canMove = !get_node("FixedRot/WalkRayW").is_colliding()
		elif (dir == DIR_SW):
			canMove = !get_node("FixedRot/WalkRaySW").is_colliding()
		elif (dir == DIR_S):
			canMove = !get_node("FixedRot/WalkRayS").is_colliding()
		elif (dir == DIR_SE):
			canMove = !get_node("FixedRot/WalkRaySE").is_colliding()
		elif (dir == DIR_E):
			canMove = !get_node("FixedRot/WalkRayE").is_colliding()
		elif (dir == DIR_NE):
			canMove = !get_node("FixedRot/WalkRayNE").is_colliding()

		if (canMove):
			if (!animation_player.is_playing()):
				animation_player.play("Walk")

			if (btn_top_pressed):
				move(Vector2(0, -speed))
			if (btn_right_pressed):
				move(Vector2(speed, 0))
			if (btn_bottom_pressed):
				move(Vector2(0, speed))
			if (btn_left_pressed):
				move(Vector2(-speed, 0))
	elif (animation_player.get_current_animation() != "PlayerDrill"):
		animation_player.stop()

	if (Input.is_action_just_pressed("PlayerPunch")):
		punch_leak()

func punch_leak():
	animation_player.play("PlayerDrill")
	get_node("SfxPlayer").play()
	var ray = get_node("DrillRay")
	if (ray.is_colliding()):
		var new_leak = leak_dummy.instance()

		leaks.add_child(new_leak)
		var offset = (ray.get_collision_point() - get_global_pos()).normalized() * 8
		new_leak.set_global_pos(ray.get_collision_point() + offset)
		var hit_dir = ray.get_collision_normal()
		var hit_rot = atan2(hit_dir.x, hit_dir.y)
		new_leak.set_global_rot((get_global_rot() + hit_rot) / 2)

		var leak_dir = Utils.radians_to_vec(new_leak.get_rot())
		capsule.add_force(new_leak.get_pos(), leak_dir * 500)
