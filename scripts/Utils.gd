extends Node

func radians_to_vec(radians):
	return Vector2(sin(radians), cos(radians)).normalized()

func vec_to_radians(vec):
	return atan2(vec.x, vec.y) 