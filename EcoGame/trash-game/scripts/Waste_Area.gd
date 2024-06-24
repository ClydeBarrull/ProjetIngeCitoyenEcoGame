extends Area2D

class_name Waste_Area

@export var tri : String = ""

signal Correct
signal Wrong

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))

func _on_area_entered(area):
	print("Area entered: ", area.name)  # Débogage pour voir quand une zone est entrée
	if area is Area2D and "bin_type" in area:
		var bin_type = area.get("bin_type")
		print("Collision with bin type: ", bin_type)
	
		if tri == bin_type:
			print("Correct type of waste for this bin.")
			Correct.emit()
		else:
			print("Incorrect type of waste for this bin.")
			Wrong.emit()
	else:
		print("The colliding area does not have a bin_type attribute.")

func _on_area_exited(area):
	pass
