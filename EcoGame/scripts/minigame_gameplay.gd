extends Node2D

#ABSTRACT CLASS
class_name MinigameGameplay

signal Completed
signal Failed

@export var TimeLimit : int = 15

@export var WrongsThreshold : int = 1
@export var CorrectsThresholds : int = 10

enum STATES {PLAYING, PAUSED}
var state = STATES.PAUSED

#ABSTRACT FUNCTION
func Start():
	state = STATES.PLAYING
	print("Tried to start Minigame gameplay on the base abstract MinigameGameplay class !")
	
func Pause():
	state = STATES.PAUSED
	print("Tried to pause Minigame gameplay on the base abstract MinigameGameplay class !")
	
func WrongRegistered(howMany:int=1):
	WrongsThreshold -= howMany
	if (WrongsThreshold <= 0) :
		Fail()
		
func CorrectRegistered(howMany:int=1):
	CorrectsThresholds -= howMany
	if (CorrectsThresholds <= 0):
		Wins()
		
func Fail():
	Failed.emit()

func Wins():
	Completed.emit()
	
func _on_win_button_pressed():
	if state == STATES.PLAYING:
		CorrectRegistered()

func _on_fail_button_pressed():
	if state == STATES.PLAYING :
		WrongRegistered()
