extends Area2D

@export var bin_type = ""

func _ready():
	bin_type = get_parent().bin_type
	var touch_detection = get_node("../TouchDetection")
	if touch_detection:
		touch_detection.connect("input_event", Callable(self, "_on_TouchDetection_input_event"))
	else:
		print("TouchDetection node not found")

func _on_TouchDetection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		await get_tree().create_timer(0.1).timeout
		bin_type = get_parent().bin_type
		print(bin_type)
