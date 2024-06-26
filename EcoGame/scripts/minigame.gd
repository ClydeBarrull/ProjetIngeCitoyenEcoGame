extends Node

class_name Minigame

signal MinigameCompleted

enum STATES {PLAYING, PAUSED, READING}
var state = STATES.PAUSED

var Gameplay : MinigameGameplay
var Success : SuccessMessage
var Failure : FailureMessage

func _ready():
	Gameplay = Utilities.getFirstChildOfType(self,MinigameGameplay)
	Success = Utilities.getFirstChildOfType(self,SuccessMessage)
	Failure = Utilities.getFirstChildOfType(self,FailureMessage)
	
	Gameplay.Failed.connect(MinigameFailed)
	
	Gameplay.Completed.connect(End)
	Failure.Closed.connect(End)
	
func Play():
	state = STATES.PLAYING
	Gameplay.Start()
	
func Pause():
	state = STATES.PAUSED
	Gameplay.Pause()
	
func MinigameFailed():
	Pause()
	Failure.ShowMessage();

func End():
	MinigameCompleted.emit()
	
