extends Node2D

#ABSTRACT CLASS
class_name MinigameGameplay

signal Completed
signal Failed

const BOMBTIMERPATH = "res://scenes/bomb_timer.tscn"
const VEILPATH = "res://scenes/veil.tscn"

@export var TimeLimit : int = 15

@export var WrongsThreshold : int = 1
@export var CorrectsThresholds : int = 10

enum STATES {PLAYING, PAUSED}
var state = STATES.PAUSED

var bombTimer : BombTimer
var veil : Sprite2D

#ABSTRACT FUNCTION

func InitializeTimerAndVeil():
	bombTimer = Utilities.CreateInstance(BOMBTIMERPATH,self)
	veil = Utilities.CreateInstance(VEILPATH,self)
	
	bombTimer.timeout.connect(Fail)
	bombTimer.setTime(TimeLimit)

func KillTimer():
	bombTimer.timeout.disconnect(Fail)
	bombTimer.queue_free()

func Start():
	state = STATES.PLAYING
	InitializeTimerAndVeil()
	if (get_class() == "MinigameGameplay"):
		push_error("Tried to start Minigame gameplay on the base abstract MinigameGameplay class !")
	
func Pause():
	state = STATES.PAUSED
	if (get_class() == "MinigameGameplay"):
		push_error("Tried to pause Minigame gameplay on the base abstract MinigameGameplay class !")
	
func WrongRegistered(howMany:int=1):
	WrongsThreshold -= howMany
	if (WrongsThreshold <= 0) :
		Fail()
		
func CorrectRegistered(howMany:int=1):
	CorrectsThresholds -= howMany
	if (CorrectsThresholds <= 0):
		Wins()
		
func Fail():
	KillTimer()
	veil.visible = true
	Failed.emit()

func Wins():
	KillTimer()
	Completed.emit()
	
func _on_win_button_pressed():
	if state == STATES.PLAYING:
		CorrectRegistered()

func _on_fail_button_pressed():
	if state == STATES.PLAYING :
		WrongRegistered()
