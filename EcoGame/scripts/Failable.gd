extends Node2D

class_name Failable

var failed : bool = false

func fail():
	failed = true
	(get_child(0) as Sprite2D).visible = false
	(get_child(1) as Sprite2D).visible = true
	
func isFailed():
	return failed
