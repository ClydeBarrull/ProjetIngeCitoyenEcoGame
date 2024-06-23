extends Area2D

@export var bin_type : String = "vert" 

func _ready():
	connect("area_entered", Callable(self, "_on_Area2D_area_entered"))
	connect("area_exited", Callable(self, "_on_Area2D_area_exited"))

func _on_Area2D_area_entered(area):
#	var waste_tri = area.tri 
#	print("A waste has entered with tri: ", waste_tri)
#
#	if waste_tri == bin_type: 
#		print("Correct type of waste for this bin.")
#		emit_signal("Correct")
#	else:
#		print("Incorrect type of waste for this bin.")
#		emit_signal("Wrong")
	pass
