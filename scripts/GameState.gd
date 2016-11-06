extends Node

export var oxygen = 100
var oxygen_lost_per_leak = .15

export var isGameOver = false

func _ready():
	set_process(true)

func _process(delta):
	var leaks_obj = get_node("/root/Main/Capsule/Leaks")
	var leaks_objs = leaks_obj.get_children()
	var leak_cont = leaks_objs.size()

	oxygen -= delta * leak_cont * oxygen_lost_per_leak

	if (oxygen <= 0):
		loseGame()

	for leak in leaks_objs:
		var amount = ((oxygen - 20) / 2) + 10
		leak.get_node("Particles2D").set_amount(amount)
		leak.get_node("StreamPlayer").set_volume_db(-30+(oxygen/3))
		if (isGameOver):
			leak.get_node("Particles2D").hide()

func loseGame():
	if (isGameOver):
		return

	isGameOver = true
	get_node("/root/Main/CanvasLayer/GUI/GameOver").show()
	get_node("/root/Main/CanvasLayer/GUI/SFXGameOver").play()
	print("Lose")

func winGame():
	if (isGameOver):
		return

	isGameOver = true
	get_node("/root/Main/CanvasLayer/GUI/Victory").show()
	print("Win")
