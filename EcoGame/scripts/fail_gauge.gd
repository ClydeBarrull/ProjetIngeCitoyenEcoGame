extends Node2D

class_name FailGauge

@onready var template : Node2D = $Failable

@export var NumberOfMissesAllowed : int = 2
@export_enum("Right","Left","Up","Down") var direction : String = "Right"
@export var DistanceRatio : float = 1

func _ready():
	var failableOffset : Vector2
	
	match direction:
		
		"Right":
			var textureSize = (template.get_child(0) as Sprite2D).texture.get_width() * DistanceRatio
			failableOffset = Vector2(template.position.x + textureSize,template.position.y)
			
		"Left":
			var textureSize = (template.get_child(0) as Sprite2D).texture.get_width() * DistanceRatio
			failableOffset = Vector2(template.position.x - textureSize,template.position.y)
			
		"Up":
			var textureSize = (template.get_child(0) as Sprite2D).texture.get_height() * DistanceRatio
			failableOffset = Vector2(template.position.x,template.position.y - textureSize)
			
		"Down":
			var textureSize = (template.get_child(0) as Sprite2D).texture.get_height() * DistanceRatio
			failableOffset = Vector2(template.position.x,template.position.y + textureSize)
	
	if (NumberOfMissesAllowed > 1):
		for i in (NumberOfMissesAllowed-1):
			var newFailable = template.duplicate()
			add_child(newFailable)
			newFailable.position += failableOffset * (i+1)
			
func failOne():
	for miss in get_children():
		if (!(miss as Failable).isFailed()):
			(miss as Failable).fail()
			break
