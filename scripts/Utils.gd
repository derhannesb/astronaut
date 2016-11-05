extends Node

func radians_to_vec(radians):
	return Vector2(sin(radians), cos(radians)).normalized()