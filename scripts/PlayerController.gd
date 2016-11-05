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

	if (btn_top_pressed):
		move(Vector2(0, -speed))
	if (btn_right_pressed):
		move(Vector2(speed, 0))
	if (btn_bottom_pressed):
		move(Vector2(0, speed))
	if (btn_left_pressed):
		move(Vector2(-speed, 0))

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


	if (dir != null):
		set_rotd((dir * 45))

		if (!animation_player.is_playing()):
			animation_player.play("Walk")
	else:
		animation_player.stop()

	if (Input.is_action_just_pressed("PlayerPunch")):
		punch_leak()

func punch_leak():
	var new_leak = leak_dummy.instance()
	new_leak.set_pos(get_transform().get_origin())
	new_leak.set_rot(get_rot())
	leaks.add_child(new_leak)
	
	var leak_dir = utils.radians_to_vec(new_leak.get_rot())
	capsule.add_force(new_leak.get_pos(), leak_dir * 800)
