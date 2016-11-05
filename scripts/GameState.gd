extends Node

var oxygen = 100
var oxygen_lost_per_leak = 0.1

func _ready():
	set_process(true)

func _fixed_process(delta):
	var leaks = find_node("Leaks", true, false);
	var leak_cont = leaks.get_children().size()
	
	oxygen -= delta * leak_cont * oxygen_lost_per_leak
	
	if (oxygen <= 0):
		loseGame()
	
func loseGame():
	pass

func winGame():
	pass