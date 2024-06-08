extends Button

class_name HighlightedButton

var highlighted = false
var HighlightedChild : Sprite2D
var NonHighlightedChid : Sprite2D

func _ready():
	HighlightedChild = get_child(0)
	NonHighlightedChid = get_child(1)
	mouse_entered.connect(Highlight)
	mouse_entered.connect(StopsHighlight)
	
func Highlight():
	icon = HighlightedChild.texture
	
func StopsHighlight():
	icon = NonHighlightedChid.texture
