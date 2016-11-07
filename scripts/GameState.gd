extends Node

export var oxygen = 100
var oxygen_lost_per_leak = 0.4

export var isGameOver = false
export var isGameLost = false

func _ready():
	set_process(true)

func _process(delta):
	var leaks_obj = get_node("/root/Main/Capsule/Leaks")
	var leaks_objs = leaks_obj.get_children()
	var leak_cont = leaks_objs.size()
	
	if (!isGameOver):
		oxygen -= delta * leak_cont * oxygen_lost_per_leak

	if (oxygen <= 0):
		loseGame()

	for leak in leaks_objs:
		var amount = ((oxygen - 20) / 2) + 10
		leak.get_node("Particles2D").set_amount(amount)
		var stream_player = leak.get_node("StreamPlayer")
		stream_player.set_volume_db(-30 + (oxygen / 3))

		if (oxygen <= 0):
			leak.get_node("Particles2D").hide()
			stream_player.stop()

func loseGame():
	if (isGameOver):
		return
	
	isGameLost = true
	isGameOver = true
	get_node("/root/Main/CanvasLayer/GUI/GameOver").show()
	get_node("/root/Main/CanvasLayer/GUI/SFXGameOver").play()
	get_node("/root/Main/Capsule/Player/Breathing").stop()
	print("Lose")

func winGame():
	if (isGameOver):
		return

	isGameOver = true
	
	get_node("/root/Main/CanvasLayer/GUI/Victory").show()
	var capsule = get_node("/root/Main/Capsule")
	capsule.set_linear_velocity(Vector2(0, 0))
	capsule.set_angular_velocity(0)
	capsule.set_angular_damp(1000)
	capsule.set_linear_damp(1000)

	print("Win")
