extends Node

var oxygen = 100
var oxygen_lost_per_leak = 0.2

export var isGameOver = false

func _ready():
	set_process(true)

func _process(delta):
	var leaks = get_node("/root/Main/Capsule/Leaks")
	var leak_cont = leaks.get_children().size()

	oxygen -= delta * leak_cont * oxygen_lost_per_leak

	if (oxygen <= 0):
		loseGame()

func loseGame():
	isGameOver = true

func winGame():
	pass
