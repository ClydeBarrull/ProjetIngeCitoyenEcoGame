extends Timer

class_name BombTimerComponent

var bombTimerParent : BombTimer

func setParent(parent:Node2D):
	bombTimerParent = parent
	
func _process(delta):
	bombTimerParent.updateTime(self.time_left)
