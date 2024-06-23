extends Node

class_name WastesList

var currentWaste : Waste
var SwipeableWasteList : Array
var currentIndex : int = 0

signal Success
signal Failure

func NextWaste():
	if currentWaste != null:
		currentWaste.Correct.disconnect(RegisterSuccess)
		currentWaste.Wrong.disconnect(RegisterFailure)
		currentWaste.queue_free()
	
	if currentIndex < SwipeableWasteList.size():
		currentWaste = SwipeableWasteList[currentIndex]
		currentWaste.visible = true
		currentWaste.Correct.connect(RegisterSuccess)
		currentWaste.Wrong.connect(RegisterFailure)
		currentIndex += 1
	else:
		currentWaste = null
		print("No more wastes")


func _ready():
	SwipeableWasteList = []
	var allChildren = get_children()
	for child in allChildren:
		if child is Waste:
			SwipeableWasteList.append(child)
	
	SwipeableWasteList.sort()

	NextWaste()

func _sort_wastes_by_z_index(a, b):
	return b.z_index - a.z_index

func RegisterSuccess():
	Success.emit()
	NextWaste()

func RegisterFailure():
	Failure.emit()
	NextWaste()
