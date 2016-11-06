extends Node2D

var time_elapsed = 0
var min_spawn_delay = 3
var spawn_delay = min_spawn_delay

const asteroid = preload("res://scns/Asteroid.tscn")

func _ready():
	set_process(true)

func _process(delta):
	time_elapsed += delta
	if (time_elapsed > spawn_delay):
		spawn_delay = rand_range(min_spawn_delay, min_spawn_delay*3)
		time_elapsed = 0
		var new_asteroid = asteroid.instance()
		new_asteroid.set_global_pos(get_global_pos())
		get_node("/root/Main").add_child(new_asteroid)
