extends MinigameGameplay

class_name TurnOffSinkGameplay

@onready var Sink : Sink = $Sink

func _ready():
	Sink.connect("closedWater",won)

func won():
	Completed.emit()
