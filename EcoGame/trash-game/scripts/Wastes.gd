extends Sprite2D

class_name Waste

@export var speed : int = 1000
@export var tri : String = "vert"

var start_position : Vector2
var end_position : Vector2
var touch_time_start : float
var touch_time_end : float

var moving : bool = false
var destination : Vector2

var SwipeLength : int

signal Correct
signal Wrong

func check_collision_with_bin():
	var bin_area = get_node("../../RecycleBin/Area2D")
	if bin_area.overlaps_area(self):
		print("overlap")
		Correct.emit()

func _ready():
	SwipeLength = get_viewport().get_visible_rect().size.x


func _process(delta):
	if moving:
		if self.position.distance_to(destination) <= 10:
			moving = false
		else:
			var move_vector = destination - self.position
			self.position += move_vector.normalized() * speed * delta


func GoUp():
	destination = Vector2(position.x, position.y - SwipeLength)
	moving = true
