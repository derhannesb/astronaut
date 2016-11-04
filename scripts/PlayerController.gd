extends KinematicBody2D

export var speed = 2.5;
export var init_rot = 90;

const DIR_N  = 0
const DIR_NW = 1
const DIR_W  = 2
const DIR_SW = 3
const DIR_S  = 4
const DIR_SE = 5
const DIR_E  = 6
const DIR_NE = 7

func _ready():
	set_fixed_process(true)
	pass


func _fixed_process(delta):
	var animation_player = get_node("PlayerAnimationPlayer")

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
	elif (btn_top_pressed):
		dir = DIR_N
	elif (btn_right_pressed && btn_bottom_pressed):
		dir = DIR_SE
	elif (btn_right_pressed):
		dir = DIR_E
	elif (btn_bottom_pressed && btn_left_pressed):
		dir = DIR_SW
	elif (btn_bottom_pressed):
		dir = DIR_S
	elif (btn_left_pressed && btn_top_pressed):
		dir = DIR_NW
	elif (btn_left_pressed):
		dir = DIR_W


	if (dir != null):
		set_rotd((dir * 45) - init_rot)

		if (!animation_player.is_playing()):
			animation_player.play("Walk")
	else:
		animation_player.stop();
