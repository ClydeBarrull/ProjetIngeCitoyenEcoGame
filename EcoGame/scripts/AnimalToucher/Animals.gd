extends Node2D

class_name Animals

var animals
var animalIndex : int
var selectedAnimal : Animal

# Called when the node enters the scene tree for the first time.
func _ready():
	animals = Utilities.GetListoFChildOfType(self,Animal)
	animals.shuffle()
	showNextAnimal()

func showNextAnimal():
	if (selectedAnimal) :
		selectedAnimal.hide()
		animalIndex = animalIndex + 1
		
	if animalIndex < len(animals) :
		selectedAnimal = animals[animalIndex]
		selectedAnimal.Play()
	
func behavioredWell():
	get_parent().CorrectRegistered()
	await get_tree().create_timer(0.8).timeout
	showNextAnimal()
	
func behavioredBadly():
	get_parent().WrongRegistered()
	await get_tree().create_timer(0.8).timeout
	showNextAnimal()
